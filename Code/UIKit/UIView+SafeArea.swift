import UIKit

@available(iOS 11.0, tvOS 11.0, *)
public extension UIView
{
    var parentSafeArea: UILayoutGuide? { superview?.safeArea }
    var safeArea: UILayoutGuide { safeAreaLayoutGuide }
}

@available(iOS 11.0, tvOS 11.0, *)
public extension UILayoutGuide
{
    var parentSafeArea: UILayoutGuide? { owningView?.safeArea }
}
