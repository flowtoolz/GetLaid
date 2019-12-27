#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    @discardableResult
    func constrainSize(to width: CGFloat,
                       _ height: CGFloat) -> [NSLayoutConstraint]
    {
        [self.width.constrain(to: width), self.height.constrain(to: height)]
    }
    
    @discardableResult
    func constrainSize(to target: LayoutItem) -> [NSLayoutConstraint]
    {
        [constrain(to: target.width), constrain(to: target.height)]
    }
    
    @discardableResult
    func constrainSize(to relativeSize: CGFloat,
                       of target: LayoutItem) -> [NSLayoutConstraint]
    {
        constrainSize(to: relativeSize, relativeSize, of: target)
    }
    
    @discardableResult
    func constrainSize(to relativeWidth: CGFloat,
                       _ relativeHeight: CGFloat,
                       of target: LayoutItem) -> [NSLayoutConstraint]
    {
        constrain(to: target.width.at(relativeWidth))
            + constrain(to: target.height.at(relativeHeight))
    }
}
