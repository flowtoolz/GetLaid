import AppKit

extension NSLayoutGuide: LayoutItem
{
    public var parent: LayoutView? { owningView }
}

extension NSView: LayoutView
{
    public var parent: LayoutView? { superview }
}
