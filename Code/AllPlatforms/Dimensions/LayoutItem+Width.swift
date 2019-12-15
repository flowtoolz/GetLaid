#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    @discardableResult
    func constrainWidth(to size: CGFloat) -> NSLayoutConstraint
    {
        constrain(.width, to: size)
    }
    
    @discardableResult
    func constrainWidth(toMinimum minimum: CGFloat) -> NSLayoutConstraint
    {
        constrain(.width, toMinimum: minimum)
    }
    
    @discardableResult
    func constrainWidth(toMaximum maximum: CGFloat) -> NSLayoutConstraint
    {
        constrain(.width, toMaximum: maximum)
    }
    
    @discardableResult
    func constrainWidth(to target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.width, to: target)
    }
    
    @discardableResult
    func constrainWidth(to relativeSize: CGFloat,
                        of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.width, to: target, multiplier: relativeSize)
    }
    
    @discardableResult
    func constrainAspectRatio(to ratio: CGFloat) -> NSLayoutConstraint
    {
        constrainWidth(to: ratio, ofHeightOf: self)
    }
    
    @discardableResult
    func constrainWidthToHeight(of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.width, to: .height, of: target)
    }
    
    @discardableResult
    func constrainWidth(to relativeSize: CGFloat,
                        ofHeightOf target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.width, to: .height, of: target, multiplier: relativeSize)
    }
}
