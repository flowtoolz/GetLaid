#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    @discardableResult
    func constrainCenterXToParent(offset: CGFloat = 0) -> NSLayoutConstraint?
    {
        parent.map { constrainCenterX(to: $0, offset: offset) }
    }
    
    @discardableResult
    func constrainCenterXToParent(minimumOffset: CGFloat) -> NSLayoutConstraint?
    {
        parent.map { constrainCenterX(to: $0, minimumOffset: minimumOffset) }
    }
    
    @discardableResult
    func constrainCenterXToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        parent.map { constrainCenterX(to: fraction, of: .trailing, of: $0) }
    }
}

public extension LayoutItem
{
    // MARK: - Offset
    
    @discardableResult
    func constrainCenterX(to target: LayoutItem,
                          offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrainCenterX(to: .centerX, of: target, offset: offset)
    }
    
    @discardableResult
    func constrainCenterX(to targetPosition: XPosition,
                          of target: LayoutItem,
                          offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.centerX, to: targetPosition, of: target, offset: offset)
    }
    
    // MARK: - Minimum Offset
    
    @discardableResult
    func constrainCenterX(to target: LayoutItem,
                          minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrainCenterX(to: .centerX, of: target, minimumOffset: minimumOffset)
    }
    
    @discardableResult
    func constrainCenterX(to targetPosition: XPosition,
                          of target: LayoutItem,
                          minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.centerX, to: targetPosition, of: target, minimumOffset: minimumOffset)
    }
    
    // MARK: - Factor
    
    @discardableResult
    func constrainCenterX(to factor: CGFloat,
                          of targetPosition: XPosition = .centerX,
                          of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.centerX, to: factor, of: targetPosition, of: target)
    }
}
