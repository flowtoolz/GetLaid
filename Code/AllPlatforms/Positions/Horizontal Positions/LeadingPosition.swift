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
        guard let parent = parent else { return nil }
        
        return constrainLeading(to: parent, offset: inset)
    }
    
    @discardableResult
    func constrainLeadingToParent(minimumInset: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        let constraint = leadingAnchor.constraint(greaterThanOrEqualTo: parent.leadingAnchor,
                                                  constant: minimumInset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func constrainLeadingToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainLeading(to: fraction, of: .trailing, of: parent)
    }
}

public extension LayoutItem
{
    // MARK: - Offset
    
    @discardableResult
    func constrain(after target: LayoutItem,
                   gap: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.leading, to: .trailing, of: target, offset: gap)
    }
    
    @discardableResult
    func constrainLeading(to target: LayoutItem,
                          offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.leading, to: .leading, of: target, offset: offset)
    }
    
    // MARK: - Minimum Offset
    
    @discardableResult
    func constrain(after target: LayoutItem,
                   minimumGap: CGFloat) -> NSLayoutConstraint
    {
        let constraint = leadingAnchor.constraint(greaterThanOrEqualTo: target.trailingAnchor,
                                                  constant: minimumGap)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func constrainLeading(to target: LayoutItem,
                          minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.leading, to: .leading, of: target, minimumOffset: minimumOffset)
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
