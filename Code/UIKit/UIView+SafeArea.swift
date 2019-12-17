import UIKit

@available(iOS 11.0, tvOS 11.0, *)
public extension UIView
{
    // MARK: - Constrain Four Edges to Parent Safe Area
    
    @discardableResult
    func constrainToParentSafeArea(insetTop: CGFloat = 0,
                                   insetLeft: CGFloat,
                                   insetBottom: CGFloat = 0,
                                   insetRight: CGFloat) -> [NSLayoutConstraint]
    {
        parentSafeArea.map
        {
            constrain(to: $0,
                      offsetTop: insetTop,
                      offsetLeading: insetLeft,
                      offsetBottom: -insetBottom,
                      offsetTrailing: -insetRight)
        } ?? []
    }
    
    @discardableResult
    func constrainToParentSafeArea(insetTop: CGFloat = 0,
                                   insetLeading: CGFloat = 0,
                                   insetBottom: CGFloat = 0,
                                   insetTrailing: CGFloat = 0) -> [NSLayoutConstraint]
    {
        parentSafeArea.map
        {
            constrain(to: $0,
                      offsetTop: insetTop,
                      offsetLeading: insetLeading,
                      offsetBottom: -insetBottom,
                      offsetTrailing: -insetTrailing)
        } ?? []
    }
    
    // MARK: - Constrain One Edge to Parent Safe Area
    
    @discardableResult
    func constrainTopToParentSafeArea(inset: CGFloat = 0) -> NSLayoutConstraint?
    {
        parentSafeArea.map { constrainTop(to: $0, offset: inset) }
    }
    
    @discardableResult
    func constrainTopToParentSafeArea(minimumInset: CGFloat) -> NSLayoutConstraint?
    {
        parentSafeArea.map { constrainTop(to: $0, minimumOffset: minimumInset) }
    }
    
    @discardableResult
    func constrainLeadingToParentSafeArea(inset: CGFloat = 0) -> NSLayoutConstraint?
    {
        parentSafeArea.map { constrainLeading(to: $0, offset: inset) }
    }
    
    @discardableResult
    func constrainLeadingToParentSafeArea(minimumInset: CGFloat) -> NSLayoutConstraint?
    {
        parentSafeArea.map { constrainLeading(to: $0, minimumOffset: minimumInset) }
    }
    
    @discardableResult
    func constrainLeftToParentSafeArea(inset: CGFloat = 0) -> NSLayoutConstraint?
    {
        parentSafeArea.map { constrainLeft(to: $0, offset: inset) }
    }
    
    @discardableResult
    func constrainLeftToParentSafeArea(minimumInset: CGFloat) -> NSLayoutConstraint?
    {
        parentSafeArea.map { constrainLeft(to: $0, minimumOffset: minimumInset) }
    }
    
    @discardableResult
    func constrainBottomToParentSafeArea(inset: CGFloat = 0) -> NSLayoutConstraint?
    {
        parentSafeArea.map { constrainBottom(to: $0, offset: -inset) }
    }
    
    @discardableResult
    func constrainBottomToParentSafeArea(minimumInset: CGFloat) -> NSLayoutConstraint?
    {
        parentSafeArea.map
        {
            bottomAnchor.constraint(lessThanOrEqualTo: $0.bottomAnchor,
                                    constant: -minimumInset)
        }
    }
    
    @discardableResult
    func constrainTrailingToParentSafeArea(inset: CGFloat = 0) -> NSLayoutConstraint?
    {
        parentSafeArea.map { constrainTrailing(to: $0, offset: -inset) }
    }
    
    @discardableResult
    func constrainTrailingToParentSafeArea(minimumInset: CGFloat) -> NSLayoutConstraint?
    {
        parentSafeArea.map
        {
            trailingAnchor.constraint(lessThanOrEqualTo: $0.trailingAnchor,
                                      constant: -minimumInset)
        }
    }
    
    @discardableResult
    func constrainRightToParentSafeArea(inset: CGFloat = 0) -> NSLayoutConstraint?
    {
        parentSafeArea.map { constrainRight(to: $0, offset: -inset) }
    }
    
    @discardableResult
    func constrainRightToParentSafeArea(minimumInset: CGFloat) -> NSLayoutConstraint?
    {
        parentSafeArea.map
        {
            rightAnchor.constraint(lessThanOrEqualTo: $0.rightAnchor,
                                   constant: -minimumInset)
        }
    }
    
    var parentSafeArea: UILayoutGuide? { superview?.safeArea }
    var safeArea: UILayoutGuide { safeAreaLayoutGuide }
}
