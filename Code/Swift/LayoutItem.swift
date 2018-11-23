#if os(OSX)
import AppKit
typealias LayoutAttribute = NSLayoutConstraint.Attribute
#else
import UIKit
typealias LayoutAttribute = NSLayoutAttribute
#endif

public protocol LayoutItem: AnyObject
{
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    
    var topAnchor: NSLayoutYAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
}
