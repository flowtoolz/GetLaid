#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension LayoutItem
{
    @discardableResult
    public func constrainHeight(to size: CGFloat) -> NSLayoutConstraint
    {
        return constrain(.height, to: size)
    }
    
    @discardableResult
    public func constrainHeight(toMinimum minimum: CGFloat) -> NSLayoutConstraint
    {
        return constrain(.height, toMinimum: minimum)
    }
    
    @discardableResult
    public func constrainHeight(toMaximum maximum: CGFloat) -> NSLayoutConstraint
    {
        return constrain(.height, toMaximum: maximum)
    }
    
    @discardableResult
    public func constrainHeight(to target: LayoutItem) -> NSLayoutConstraint
    {
        return constrain(.height, to: target)
    }
    
    @discardableResult
    public func constrainHeight(to relativeSize: CGFloat,
                                of target: LayoutItem) -> NSLayoutConstraint
    {
        return constrain(.height, to: target, multiplier: relativeSize)
    }
}
