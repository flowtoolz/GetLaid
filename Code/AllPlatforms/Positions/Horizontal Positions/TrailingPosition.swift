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
        guard let parent = parent else { return nil }
        
        return constrainTrailing(to: parent, offset: -inset)
    }
    
    @discardableResult
    func constrainTrailingToParent(minimumInset: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        let constraint = trailingAnchor.constraint(lessThanOrEqualTo: parent.trailingAnchor,
                                                   constant: -minimumInset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func constrainTrailingToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainTrailing(to: fraction, of: .trailing, of: parent)
    }
}

public extension LayoutItem
{
    // MARK: - Offset
    
    @discardableResult
    func constrain(before target: LayoutItem,
                   gap: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.trailing, to: .leading, of: target, offset: -gap)
    }
    
    @discardableResult
    func constrainTrailing(to target: LayoutItem,
                           offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.trailing, to: .trailing, of: target, offset: offset)
    }
    
    // MARK: - Minimum Offset
    
    @discardableResult
    func constrain(before target: LayoutItem,
                   minimumGap: CGFloat) -> NSLayoutConstraint
    {
        let constraint = trailingAnchor.constraint(lessThanOrEqualTo: target.leadingAnchor,
                                                   constant: -minimumGap)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func constrainTrailing(to target: LayoutItem,
                           minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.trailing, to: .trailing, of: target, minimumOffset: minimumOffset)
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
