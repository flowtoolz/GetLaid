#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    // MARK: - To Absolute Points
    
    @discardableResult
    func constrainHeight(to size: CGFloat) -> NSLayoutConstraint
    {
        height.constrain(to: .exact(size))
    }
    
    @discardableResult
    func constrainHeight(toMinimum minimum: CGFloat) -> NSLayoutConstraint
    {
        height.constrain(to: .min(minimum))
    }
    
    @discardableResult
    func constrainHeight(toMaximum maximum: CGFloat) -> NSLayoutConstraint
    {
        height.constrain(to: .max(maximum))
    }
    
    // MARK: - To Target
    
    @discardableResult
    func constrainHeight(to target: LayoutItem) -> NSLayoutConstraint
    {
        height.constrain(to: target.height)
    }
    
    @discardableResult
    func constrainHeight(to factor: CGFloat,
                         of target: LayoutItem) -> NSLayoutConstraint
    {
        height.constrain(to: target.height.at(factor))
    }
    
    // MARK: - To Width
    
    @discardableResult
    func constrainHeightToWidth(of target: LayoutItem) -> NSLayoutConstraint
    {
        height.constrain(to: target.width)
    }
    
    @discardableResult
    func constrainHeight(to factor: CGFloat,
                         ofWidthOf target: LayoutItem) -> NSLayoutConstraint
    {
        height.constrain(to: target.width.at(factor))
    }
}
