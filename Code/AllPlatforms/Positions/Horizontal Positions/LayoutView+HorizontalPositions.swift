#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    // MARK: - Absolute Positioning
    
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
    func constrainCenterXToParent(offset: CGFloat = 0) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainCenterX(to: parent, offset: offset)
    }
    
    @discardableResult
    func constrainCenterXToParent(minimumOffset: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainCenterX(to: parent, minimumOffset: minimumOffset)
    }
    
    // MARK: - Absolute Horizontal Positioning - Via Leading/Trailing
    
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
    
    // MARK: - Relative Positioning
    
    @discardableResult
    func constrainLeftToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainLeft(to: fraction, of: .right, of: parent)
    }
    
    @discardableResult
    func constrainRightToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainRight(to: fraction, of: .right, of: parent)
    }
    
    @discardableResult
    func constrainCenterXToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainCenterX(to: fraction, of: .trailing, of: parent)
    }
    
    @discardableResult
    func constrainLeadingToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainLeading(to: fraction, of: .trailing, of: parent)
    }
    
    @discardableResult
    func constrainTrailingToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainTrailing(to: fraction, of: .trailing, of: parent)
    }
}
