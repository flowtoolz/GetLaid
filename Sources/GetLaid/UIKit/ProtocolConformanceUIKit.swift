#if os(iOS) || os(tvOS)
import UIKit

extension UILayoutGuide: LayoutItem
{
    public var parent: LayoutView? { owningView }
}

extension UIView: LayoutView
{
    public var parent: LayoutView? { return superview }
}

#endif
