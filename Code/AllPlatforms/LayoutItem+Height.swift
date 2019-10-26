#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    @discardableResult
    func constrainHeight(to size: CGFloat) -> NSLayoutConstraint
    {
        constrain(.height, to: size)
    }
    
    @discardableResult
    func constrainHeight(toMinimum minimum: CGFloat) -> NSLayoutConstraint
    {
        constrain(.height, toMinimum: minimum)
    }
    
    @discardableResult
    func constrainHeight(toMaximum maximum: CGFloat) -> NSLayoutConstraint
    {
        constrain(.height, toMaximum: maximum)
    }
    
    @discardableResult
    func constrainHeight(to target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.height, to: target)
    }
    
    @discardableResult
    func constrainHeight(to relativeSize: CGFloat,
                         of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.height, to: target, multiplier: relativeSize)
    }
    
    @discardableResult
    func constrainHeightToWidth(of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.height, to: .width, of: target)
    }
    
    @discardableResult
    func constrainHeight(to relativeSize: CGFloat,
                         ofWidthOf target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.height, to: .width, of: target, multiplier: relativeSize)
    }
}
