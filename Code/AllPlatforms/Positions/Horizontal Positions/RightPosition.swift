#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    @discardableResult
    func constrainRightToParent(inset: CGFloat = 0) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainRight(to: parent, offset: -inset)
    }
    
    @discardableResult
    func constrainRightToParent(minimumInset: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        let constraint = rightAnchor.constraint(lessThanOrEqualTo: parent.rightAnchor,
                                                constant: -minimumInset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func constrainRightToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainRight(to: fraction, of: .right, of: parent)
    }
}

public extension LayoutItem
{
    // MARK: - Offset
    
    @discardableResult
    func constrain(toTheLeftOf target: LayoutItem,
                   gap: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.right, to: .left, of: target, offset: -gap)
    }
    
    @discardableResult
    func constrainRight(to target: LayoutItem,
                        offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.right, to: .right, of: target, offset: offset)
    }
    
    // MARK: - Minimum Offset
    
    @discardableResult
    func constrain(toTheLeftOf target: LayoutItem,
                   minimumGap: CGFloat) -> NSLayoutConstraint
    {
        let constraint = rightAnchor.constraint(lessThanOrEqualTo: target.leftAnchor,
                                                constant: -minimumGap)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func constrainRight(to target: LayoutItem,
                        minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.right, to: .right, of: target, minimumOffset: minimumOffset)
    }
    
    // MARK: - Factor
    
    @discardableResult
    func constrainRight(to factor: CGFloat,
                        of targetPosition: XPosition = .right,
                        of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.right, to: factor, of: targetPosition, of: target)
    }
}
