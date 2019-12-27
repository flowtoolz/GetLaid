#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension DimensionAnchor
{
    @discardableResult
    func constrain(to size: CGFloat) -> NSLayoutConstraint
    {
        constrain(to: .exact(size))
    }
}
