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
        
        return constrainTop(to: parent, minimumOffset: minimumInset)
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
    // MARK: - Offset
    
    @discardableResult
    func constrain(below target: LayoutItem,
                   gap: CGFloat = 0) -> NSLayoutConstraint
    {
        constrainTop(to: .bottom, of: target, offset: gap)
    }
    
    @discardableResult
    func constrainTop(to target: LayoutItem,
                      offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrainTop(to: .top, of: target, offset: offset)
    }
    
    @discardableResult
    func constrainTop(to targetPosition: YPosition,
                      of target: LayoutItem,
                      offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.top, to: targetPosition, of: target, offset: offset)
    }
    
    // MARK: - Minimum Offset
    
    @discardableResult
    func constrain(below target: LayoutItem,
                   minimumGap: CGFloat) -> NSLayoutConstraint
    {
        constrainTop(to: .bottom, of: target, minimumOffset: minimumGap)
    }
    
    @discardableResult
    func constrainTop(to target: LayoutItem,
                      minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrainTop(to: .top, of: target, minimumOffset: minimumOffset)
    }
    
    @discardableResult
    func constrainTop(to targetPosition: YPosition,
                      of target: LayoutItem,
                      minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.top, to: targetPosition, of: target, minimumOffset: minimumOffset)
    }
    
    // MARK: - Factor
    
    @discardableResult
    func constrainTop(to factor: CGFloat,
                      of targetPosition: YPosition = .top,
                      of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.top, to: factor, of: targetPosition, of: target)
    }
}
