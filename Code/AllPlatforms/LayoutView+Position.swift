#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    // MARK: - Absolute Positioning
    
    @discardableResult
    func constrainCenterToParent() -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [constrainCenterX(to: parent), constrainCenterY(to: parent)]
    }
    
    @discardableResult
    func constrainToParent(inset: CGFloat) -> [NSLayoutConstraint]
    {
        constrainToParent(insetTop: inset,
                          insetLeft: inset,
                          insetBottom: inset,
                          insetRight: inset)
    }
        
    @discardableResult
    func constrainToParent(insetTop: CGFloat = 0,
                           insetLeft: CGFloat,
                           insetBottom: CGFloat = 0,
                           insetRight: CGFloat) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainTop(to: parent, offset: insetTop),
                 constrainBottom(to: parent, offset: -insetBottom),
                 constrainLeft(to: parent, offset: insetLeft),
                 constrainRight(to: parent, offset: -insetRight) ]
    }
    
    @discardableResult
    func constrainToParent(insetTop: CGFloat = 0,
                           insetLeading: CGFloat = 0,
                           insetBottom: CGFloat = 0,
                           insetTrailing: CGFloat = 0) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainTop(to: parent, offset: insetTop),
                 constrainBottom(to: parent, offset: -insetBottom),
                 constrainLeading(to: parent, offset: insetLeading),
                 constrainTrailing(to: parent, offset: -insetTrailing) ]
    }
    
    @discardableResult
    func constrainToParentExcludingTop(inset: CGFloat) -> [NSLayoutConstraint]
    {
        constrainToParentExcludingTop(insetLeft: inset,
                                      insetBottom: inset,
                                      insetRight: inset)
    }
    
    @discardableResult
    func constrainToParentExcludingTop(insetLeft: CGFloat,
                                       insetBottom: CGFloat = 0,
                                       insetRight: CGFloat) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainBottom(to: parent, offset: -insetBottom),
                 constrainLeft(to: parent, offset: insetLeft),
                 constrainRight(to: parent, offset: -insetRight) ]
    }
    
    @discardableResult
    func constrainToParentExcludingTop(insetLeading: CGFloat = 0,
                                       insetBottom: CGFloat = 0,
                                       insetTrailing: CGFloat = 0) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainBottom(to: parent, offset: -insetBottom),
                 constrainLeading(to: parent, offset: insetLeading),
                 constrainRight(to: parent, offset: -insetTrailing) ]
    }
    
    @discardableResult
    func constrainToParentExcludingLeft(inset: CGFloat) -> [NSLayoutConstraint]
    {
        constrainToParentExcludingLeft(insetTop: inset,
                                       insetBottom: inset,
                                       insetRight: inset)
    }
    
    @discardableResult
    func constrainToParentExcludingLeft(insetTop: CGFloat = 0,
                                        insetBottom: CGFloat = 0,
                                        insetRight: CGFloat) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainBottom(to: parent, offset: -insetBottom),
                 constrainTop(to: parent, offset: insetTop),
                 constrainRight(to: parent, offset: -insetRight) ]
    }
    
    @discardableResult
    func constrainToParentExcludingLeft(insetTop: CGFloat = 0,
                                        insetBottom: CGFloat = 0,
                                        insetTrailing: CGFloat = 0) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainBottom(to: parent, offset: -insetBottom),
                 constrainTop(to: parent, offset: insetTop),
                 constrainTrailing(to: parent, offset: -insetTrailing) ]
    }
    
    @discardableResult
    func constrainToParentExcludingBottom(inset: CGFloat) -> [NSLayoutConstraint]
    {
        constrainToParentExcludingBottom(insetTop: inset,
                                         insetLeft: inset,
                                         insetRight: inset)
    }
    
    @discardableResult
    func constrainToParentExcludingBottom(insetTop: CGFloat = 0,
                                          insetLeft: CGFloat,
                                          insetRight: CGFloat) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainRight(to: parent, offset: -insetRight),
                 constrainTop(to: parent, offset: insetTop),
                 constrainLeft(to: parent, offset: insetLeft) ]
    }
    
    @discardableResult
    func constrainToParentExcludingBottom(insetTop: CGFloat = 0,
                                          insetLeading: CGFloat = 0,
                                          insetTrailing: CGFloat = 0) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainTrailing(to: parent, offset: -insetTrailing),
                 constrainTop(to: parent, offset: insetTop),
                 constrainLeading(to: parent, offset: insetLeading) ]
    }
    
    @discardableResult
    func constrainToParentExcludingRight(inset: CGFloat) -> [NSLayoutConstraint]
    {
        constrainToParentExcludingRight(insetTop: inset,
                                        insetLeft: inset,
                                        insetBottom: inset)
    }
    
    @discardableResult
    func constrainToParentExcludingRight(insetTop: CGFloat = 0,
                                         insetLeft: CGFloat,
                                         insetBottom: CGFloat = 0) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainBottom(to: parent, offset: -insetBottom),
                 constrainTop(to: parent, offset: insetTop),
                 constrainLeft(to: parent, offset: insetLeft) ]
    }
    
    @discardableResult
    func constrainToParentExcludingRight(insetTop: CGFloat = 0,
                                         insetLeading: CGFloat = 0,
                                         insetBottom: CGFloat = 0) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainBottom(to: parent, offset: -insetBottom),
                 constrainTop(to: parent, offset: insetTop),
                 constrainLeading(to: parent, offset: insetLeading) ]
    }
    
    @discardableResult
    func constrainTopToParent(inset: CGFloat = 0) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainTop(to: parent, offset: inset)
    }
    
    @discardableResult
    func constrainTopToParent(minimumInset: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        let constraint = topAnchor.constraint(greaterThanOrEqualTo: parent.topAnchor,
                                              constant: minimumInset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func constrainBottomToParent(inset: CGFloat = 0) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainBottom(to: parent, offset: -inset)
    }
    
    @discardableResult
    func constrainBottomToParent(minimumInset: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        let constraint = bottomAnchor.constraint(lessThanOrEqualTo: parent.bottomAnchor,
                                                 constant: -minimumInset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func constrainCenterYToParent(offset: CGFloat = 0) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainCenterY(to: parent, offset: offset)
    }
    
    @discardableResult
    func constrainCenterYToParent(minimumOffset: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainCenterY(to: parent, minimumOffset: minimumOffset)
    }
    
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
    
    // MARK: - Horizontal Positioning - Via Leading/Trailing
    
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
    func constrainTopToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainTop(to: fraction, of: .bottom, of: parent)
    }
    
    @discardableResult
    func constrainBottomToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainBottom(to: fraction, of: .bottom, of: parent)
    }
    
    @discardableResult
    func constrainCenterYToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainCenterY(to: fraction, of: .bottom, of: parent)
    }
    
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
        
        return constrainCenterX(to: fraction, of: .right, of: parent)
    }
}
