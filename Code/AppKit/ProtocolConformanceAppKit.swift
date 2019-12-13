import AppKit

extension NSLayoutGuide: LayoutItem {}

extension NSView: LayoutView
{
    public var parent: LayoutView? { superview }
}
