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
    
    // MARK: - To Target
    
    @discardableResult
    func constrainHeight(to target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(to: target.height)
    }
    
    @discardableResult
    func constrainHeight(to factor: CGFloat,
                         of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(to: target.height.at(factor))
    }
    
    // MARK: - To Width
    
    @discardableResult
    func constrainHeightToWidth(of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.height, to: target.width)
    }
    
    @discardableResult
    func constrainHeight(to factor: CGFloat,
                         ofWidthOf target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.height, to: target.width.at(factor))
    }
}
