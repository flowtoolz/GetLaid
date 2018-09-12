#if os(OSX)
import AppKit
typealias LayoutAttribute = NSLayoutConstraint.Attribute
#else
import UIKit
typealias LayoutAttribute = NSLayoutAttribute
#endif

public protocol LayoutItem
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

public struct Insets
{
    public init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
    {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }
    
    var top, left, bottom, right: CGFloat
    
    public static var zero: Insets
    {
        return Insets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
