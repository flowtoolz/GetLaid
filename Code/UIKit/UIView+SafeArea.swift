import UIKit

@available(iOS 11.0, tvOS 11.0, *)
public extension UIView
{
    func constrainToParentSafeArea() -> [NSLayoutConstraint]
    {
        guard let parentSafeArea = parentSafeArea else { return [] }
        return constrain(to: parentSafeArea)
    }
    
    var parentSafeArea: UILayoutGuide? { superview?.safeArea }
    var safeArea: UILayoutGuide { safeAreaLayoutGuide }
}
