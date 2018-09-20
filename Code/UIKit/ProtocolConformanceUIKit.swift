import UIKit

extension UILayoutGuide: LayoutItem {}

extension UIView: LayoutChild
{
    public var parent: LayoutItem? { return superview }
}
