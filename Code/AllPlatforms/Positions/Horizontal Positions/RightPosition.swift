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
        parent.map { constrainRight(to: $0, offset: -inset) }
    }
    
    @discardableResult
    func constrainRightToParent(minimumInset: CGFloat) -> NSLayoutConstraint?
    {
        parent.map
        {
            rightAnchor.constraint(lessThanOrEqualTo: $0.rightAnchor,
                                   constant: -minimumInset).activate()
        }
    }
    
    @discardableResult
    func constrainRightToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        parent.map { constrainRight(to: fraction, of: .right, of: $0) }
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
        rightAnchor.constraint(lessThanOrEqualTo: target.leftAnchor,
                               constant: -minimumGap).activate()
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
