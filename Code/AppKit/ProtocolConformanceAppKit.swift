import AppKit

extension NSLayoutGuide: LayoutItem {}

extension NSView: LayoutChild
{
    public var parent: LayoutItem? { return superview }
}
