#if os(macOS)
import AppKit
#endif

@available(macOS 10.11, *)
extension NSLayoutGuide: LayoutItem
{
    public var parent: LayoutView? { owningView }
}

@available(macOS 10.11, *)
extension NSView: LayoutView
{
    public var parent: LayoutView? { superview }
}
