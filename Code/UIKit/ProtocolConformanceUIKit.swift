import UIKit

extension UILayoutGuide: LayoutItem {}

extension UIView: LayoutChild
{
    var parent: LayoutItem? { return superview }
}
