#if os(OSX)
import AppKit
#else
import UIKit
#endif

public protocol LayoutView: LayoutItem
{
    var firstBaselineAnchor: NSLayoutYAxisAnchor { get }
    var lastBaselineAnchor: NSLayoutYAxisAnchor { get }
}
