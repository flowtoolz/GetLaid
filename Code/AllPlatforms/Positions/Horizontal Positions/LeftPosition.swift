#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    @discardableResult
    func constrainLeftToParent(inset: CGFloat = 0) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainLeft(to: parent, offset: inset)
    }
    
    @discardableResult
    func constrainLeftToParent(minimumInset: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        let constraint = leftAnchor.constraint(greaterThanOrEqualTo: parent.leftAnchor,
                                               constant: minimumInset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func constrainLeftToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainLeft(to: fraction, of: .right, of: parent)
    }
}

public extension LayoutItem
{
    // MARK: - Offset
    
    @discardableResult
    func constrain(toTheRightOf target: LayoutItem,
                   gap: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.left, to: .right, of: target, offset: gap)
    }
    
    @discardableResult
    func constrainLeft(to target: LayoutItem,
                       offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.left, to: .left, of: target, offset: offset)
    }
    
    // MARK: - Minimum Offset
    
    @discardableResult
    func constrain(toTheRightOf target: LayoutItem,
                   minimumGap: CGFloat) -> NSLayoutConstraint
    {
        let constraint = leftAnchor.constraint(greaterThanOrEqualTo: target.rightAnchor,
                                               constant: minimumGap)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func constrainLeft(to target: LayoutItem,
                       minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.left, to: .left, of: target, minimumOffset: minimumOffset)
    }
    
    // MARK: - Factor
    
    @discardableResult
    func constrainLeft(to factor: CGFloat,
                       of targetPosition: XPosition = .left,
                       of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.left, to: factor, of: targetPosition, of: target)
    }
}
