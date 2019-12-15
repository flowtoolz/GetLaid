#if os(OSX)
import AppKit
#else
import UIKit
#endif

typealias LayoutAttribute = NSLayoutConstraint.Attribute

public extension NSLayoutConstraint
{
    func activate() -> Self
    {
        isActive = true
        return self
    }
}
