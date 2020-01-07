#if os(iOS) || os(tvOS)
import UIKit
#endif

@available(iOS 9.0, tvOS 9.0, *)
extension UILayoutGuide: LayoutItem
{
    public var parent: LayoutView? { owningView }
}

@available(iOS 9.0, tvOS 9.0, *)
extension UIView: LayoutView
{
    public var parent: LayoutView? { return superview }
}
