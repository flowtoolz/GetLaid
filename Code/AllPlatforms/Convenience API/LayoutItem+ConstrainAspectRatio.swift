#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    // TODO: turn aspect ratio into a combined anchor?
    
    @discardableResult
    func constrainAspectRatio(to ratio: CGFloat) -> NSLayoutConstraint?
    {
        width.constrain(to: height.at(ratio))
    }
}
