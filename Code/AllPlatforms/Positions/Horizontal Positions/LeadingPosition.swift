#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    @discardableResult
    func constrainLeadingToParent(inset: CGFloat = 0) -> NSLayoutConstraint?
    {
        parent.map { constrainLeading(to: $0, offset: inset) }
    }
    
    @discardableResult
    func constrainLeadingToParent(minimumInset: CGFloat) -> NSLayoutConstraint?
    {
        parent.map { constrainLeading(to: $0, minimumOffset: minimumInset) }
    }
    
    @discardableResult
    func constrainLeadingToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        parent.map { constrainLeading(to: fraction, of: .trailing, of: $0) }
    }
}

public extension LayoutItem
{
    // MARK: - Offset
    
    @discardableResult
    func constrain(after target: LayoutItem,
                   gap: CGFloat = 0) -> NSLayoutConstraint
    {
        constrainLeading(to: .trailing, of: target, offset: gap)
    }
    
    @discardableResult
    func constrainLeading(to target: LayoutItem,
                          offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrainLeading(to: .leading, of: target, offset: offset)
    }
    
    @discardableResult
    func constrainLeading(to targetPosition: XPosition,
                          of target: LayoutItem,
                          offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.leading, to: targetPosition, of: target, offset: offset)
    }
    
    // MARK: - Minimum Offset
    
    @discardableResult
    func constrain(after target: LayoutItem,
                   minimumGap: CGFloat) -> NSLayoutConstraint
    {
        constrainLeading(to: .trailing, of: target, minimumOffset: minimumGap)
    }
    
    @discardableResult
    func constrainLeading(to target: LayoutItem,
                          minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrainLeading(to: .leading, of: target, minimumOffset: minimumOffset)
    }
    
    @discardableResult
    func constrainLeading(to targetPosition: XPosition,
                          of target: LayoutItem,
                          minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.leading, to: targetPosition, of: target, minimumOffset: minimumOffset)
    }
    
    // MARK: - Factor
    
    @discardableResult
    func constrainLeading(to factor: CGFloat,
                          of targetPosition: XPosition = .leading,
                          of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.leading, to: factor, of: targetPosition, of: target)
    }
}
