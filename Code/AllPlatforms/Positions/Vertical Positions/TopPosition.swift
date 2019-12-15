#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    @discardableResult
    func constrainTopToParent(inset: CGFloat = 0) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainTop(to: parent, offset: inset)
    }
    
    @discardableResult
    func constrainTopToParent(minimumInset: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        let constraint = topAnchor.constraint(greaterThanOrEqualTo: parent.topAnchor,
                                              constant: minimumInset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func constrainTopToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainTop(to: fraction, of: .bottom, of: parent)
    }
}

public extension LayoutItem
{
    @discardableResult
    func constrain(below target: LayoutItem,
                   gap: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.top, to: .bottom, of: target, offset: gap)
    }
    
    @discardableResult
    func constrain(below target: LayoutItem,
                   minimumGap: CGFloat) -> NSLayoutConstraint
    {
        let constraint = topAnchor.constraint(greaterThanOrEqualTo: target.bottomAnchor,
                                              constant: minimumGap)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func constrainTop(to target: LayoutItem,
                      offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.top, to: .top, of: target, offset: offset)
    }
    
    @discardableResult
    func constrainTop(to target: LayoutItem,
                      minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.top, to: .top, of: target, minimumOffset: minimumOffset)
    }
    
    @discardableResult
    func constrainTop(to factor: CGFloat,
                      of targetPosition: YPosition = .top,
                      of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.top, to: factor, of: targetPosition, of: target)
    }
}