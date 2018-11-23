#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension LayoutItem
{
    @discardableResult
    public func constrainWidth(to size: CGFloat) -> NSLayoutConstraint
    {
        return constrain(.width, to: size)
    }
    
    @discardableResult
    public func constrainWidth(toMinimum minimum: CGFloat) -> NSLayoutConstraint
    {
        return constrain(.width, toMinimum: minimum)
    }
    
    @discardableResult
    public func constrainWidth(toMaximum maximum: CGFloat) -> NSLayoutConstraint
    {
        return constrain(.width, toMaximum: maximum)
    }
    
    @discardableResult
    public func constrainWidth(to target: LayoutItem) -> NSLayoutConstraint
    {
        return constrain(.width, to: target)
    }
    
    @discardableResult
    public func constrainWidth(to relativeSize: CGFloat,
                               of target: LayoutItem) -> NSLayoutConstraint
    {
        return constrain(.width, to: target, multiplier: relativeSize)
    }
}
