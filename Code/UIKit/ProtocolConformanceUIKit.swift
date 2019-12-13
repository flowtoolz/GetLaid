import UIKit

extension UILayoutGuide: LayoutItem {}

extension UIView: LayoutView
{
    public var parent: LayoutView? { return superview }
}
