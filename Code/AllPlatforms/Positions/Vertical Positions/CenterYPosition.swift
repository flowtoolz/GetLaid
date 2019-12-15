#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    @discardableResult
    func constrainCenterYToParent(offset: CGFloat = 0) -> NSLayoutConstraint?
    {
        parent.map { constrainCenterY(to: $0, offset: offset) }
    }
    
    @discardableResult
    func constrainCenterYToParent(minimumOffset: CGFloat) -> NSLayoutConstraint?
    {
        parent.map { constrainCenterY(to: $0, minimumOffset: minimumOffset) }
    }
    
    @discardableResult
    func constrainCenterYToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        parent.map { constrainCenterY(to: fraction, of: .bottom, of: $0) }
    }
}

public extension LayoutItem
{
    // MARK: - Offset
    
    @discardableResult
    func constrainCenterY(to target: LayoutItem,
                          offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrainCenterY(to: .centerY, of: target, offset: offset)
    }
    
    @discardableResult
    func constrainCenterY(to targetPosition: YPosition,
                          of target: LayoutItem,
                          offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.centerY, to: targetPosition, of: target, offset: offset)
    }
    
    // MARK: - Minimum Offset
    
    @discardableResult
    func constrainCenterY(to target: LayoutItem,
                          minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrainCenterY(to: .centerY, of: target, minimumOffset: minimumOffset)
    }
    
    @discardableResult
    func constrainCenterY(to targetPosition: YPosition,
                          of target: LayoutItem,
                          minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.centerY, to: targetPosition, of: target, minimumOffset: minimumOffset)
    }
    
    // MARK: - Factor
    
    @discardableResult
    func constrainCenterY(to factor: CGFloat,
                          of targetPosition: YPosition = .centerY,
                          of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.centerY, to: factor, of: targetPosition, of: target)
    }
}
