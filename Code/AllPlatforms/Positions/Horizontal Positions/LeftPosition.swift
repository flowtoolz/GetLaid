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
        parent.map { constrainLeft(to: $0, offset: inset) }
    }
    
    @discardableResult
    func constrainLeftToParent(minimumInset: CGFloat) -> NSLayoutConstraint?
    {
        parent.map { constrainLeft(to: $0, minimumOffset: minimumInset) }
    }
    
    @discardableResult
    func constrainLeftToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        parent.map { constrainLeft(to: fraction, of: .right, of: $0) }
    }
}

public extension LayoutItem
{
    // MARK: - Offset
    
    @discardableResult
    func constrain(toTheRightOf target: LayoutItem,
                   gap: CGFloat = 0) -> NSLayoutConstraint
    {
        constrainLeft(to: .right, of: target, offset: gap)
    }
    
    @discardableResult
    func constrainLeft(to target: LayoutItem,
                       offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrainLeft(to: .left, of: target, offset: offset)
    }
    
    @discardableResult
    func constrainLeft(to targetPosition: XPosition,
                       of target: LayoutItem,
                       offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.left, to: targetPosition, of: target, offset: offset)
    }
    
    // MARK: - Minimum Offset
    
    @discardableResult
    func constrain(toTheRightOf target: LayoutItem,
                   minimumGap: CGFloat) -> NSLayoutConstraint
    {
        constrainLeft(to: .right, of: target, minimumOffset: minimumGap)
    }
    
    @discardableResult
    func constrainLeft(to target: LayoutItem,
                       minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrainLeft(to: .left, of: target, minimumOffset: minimumOffset)
    }
    
    @discardableResult
    func constrainLeft(to targetPosition: XPosition,
                       of target: LayoutItem,
                       minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.left, to: targetPosition, of: target, minimumOffset: minimumOffset)
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
