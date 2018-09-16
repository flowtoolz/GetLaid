import AppKit

extension NSLayoutGuide: LayoutItem {}

extension NSView: LayoutChild
{
    var parent: LayoutItem? { return superview }
}
