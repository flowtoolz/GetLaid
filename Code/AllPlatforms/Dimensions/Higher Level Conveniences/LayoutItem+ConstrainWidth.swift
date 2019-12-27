#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    // MARK: - To Absolute Points
    
    @discardableResult
    func constrainWidth(to size: CGFloat) -> NSLayoutConstraint
    {
        width.constrain(to: .exact(size))
    }
    
    @discardableResult
    func constrainWidth(toMinimum minimum: CGFloat) -> NSLayoutConstraint
    {
        width.constrain(to: .min(minimum))
    }
    
    @discardableResult
    func constrainWidth(toMaximum maximum: CGFloat) -> NSLayoutConstraint
    {
        width.constrain(to: .max(maximum))
    }
    
    // MARK: - To Target
    
    @discardableResult
    func constrainWidth(to target: LayoutItem) -> NSLayoutConstraint
    {
        width.constrain(to: target.width)
    }
    
    @discardableResult
    func constrainWidth(to factor: CGFloat,
                        of target: LayoutItem) -> NSLayoutConstraint
    {
        width.constrain(to: target.width.at(factor))
    }
    
    // MARK: - To Height
    
    @discardableResult
    func constrainWidthToHeight(of target: LayoutItem) -> NSLayoutConstraint
    {
        width.constrain(to: target.height)
    }
    
    @discardableResult
    func constrainAspectRatio(to ratio: CGFloat) -> NSLayoutConstraint
    {
        width.constrain(to: height.at(ratio))
    }
    
    @discardableResult
    func constrainWidth(to factor: CGFloat,
                        ofHeightOf target: LayoutItem) -> NSLayoutConstraint
    {
        width.constrain(to: target.height.at(factor))
    }
}
