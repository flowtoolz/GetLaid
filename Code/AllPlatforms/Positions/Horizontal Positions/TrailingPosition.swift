#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    @discardableResult
    func constrainTrailingToParent(inset: CGFloat = 0) -> NSLayoutConstraint?
    {
        parent.map { constrainTrailing(to: $0, offset: -inset) }
    }
    
    @discardableResult
    func constrainTrailingToParent(minimumInset: CGFloat) -> NSLayoutConstraint?
    {
        parent.map
        {
            trailingAnchor.constraint(lessThanOrEqualTo: $0.trailingAnchor,
                                      constant: -minimumInset)
        }
    }
    
    @discardableResult
    func constrainTrailingToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        parent.map { constrainTrailing(to: fraction, of: .trailing, of: $0) }
    }
}

public extension LayoutItem
{
    // MARK: - Offset
    
    @discardableResult
    func constrain(before target: LayoutItem,
                   gap: CGFloat = 0) -> NSLayoutConstraint
    {
        constrainTrailing(to: .leading, of: target, offset: -gap)
    }
    
    @discardableResult
    func constrainTrailing(to target: LayoutItem,
                           offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrainTrailing(to: .trailing, of: target, offset: offset)
    }
    
    @discardableResult
    func constrainTrailing(to targetPosition: XPosition,
                           of target: LayoutItem,
                           offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.trailing, to: targetPosition, of: target, offset: offset)
    }
    
    // MARK: - Minimum Offset
    
    @discardableResult
    func constrain(before target: LayoutItem,
                   minimumGap: CGFloat) -> NSLayoutConstraint
    {
        trailingAnchor.constraint(lessThanOrEqualTo: target.leadingAnchor,
                                  constant: -minimumGap).activate()
    }
    
    @discardableResult
    func constrainTrailing(to target: LayoutItem,
                           minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrainTrailing(to: .trailing, of: target, minimumOffset: minimumOffset)
    }
    
    @discardableResult
    func constrainTrailing(to targetPosition: XPosition,
                           of target: LayoutItem,
                           minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.trailing, to: targetPosition, of: target, minimumOffset: minimumOffset)
    }
    
    // MARK: - Factor
    
    @discardableResult
    func constrainTrailing(to factor: CGFloat,
                           of targetPosition: XPosition = .trailing,
                           of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.trailing, to: factor, of: targetPosition, of: target)
    }
}
