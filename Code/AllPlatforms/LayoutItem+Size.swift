#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension LayoutItem
{
    @discardableResult
    public func constrainSize(to width: CGFloat,
                              _ height: CGFloat) -> [NSLayoutConstraint]
    {
        [constrainWidth(to: width), constrainHeight(to: height)]
    }
    
    @discardableResult
    public func constrainSize(to target: LayoutItem) -> [NSLayoutConstraint]
    {
        [constrainWidth(to: target), constrainHeight(to: target)]
    }
    
    @discardableResult
    public func constrainSize(to relativeWidth: CGFloat,
                              _ relativeHeight: CGFloat,
                              of target: LayoutItem) -> [NSLayoutConstraint]
    {
        [ constrainWidth(to: relativeWidth, of: target),
          constrainHeight(to: relativeHeight, of: target) ]
    }
}
