#if os(OSX)
import AppKit
#else
import UIKit
#endif

@available(*, deprecated, message: "This convenience will be removed or reimplemented in the GetLaid core API")
public extension LayoutItem
{
    // TODO: turn aspect ratio into a combined anchor?
    @discardableResult
    func constrainAspectRatio(to ratio: CGFloat) -> NSLayoutConstraint?
    {
        width.constrain(to: height.at(ratio))
    }
}
