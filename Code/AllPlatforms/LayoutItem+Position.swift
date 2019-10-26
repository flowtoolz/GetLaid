#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension LayoutItem
{
    @discardableResult
    public func constrainCenter(to target: LayoutItem) -> [NSLayoutConstraint]
    {
        [constrainCenterX(to: target), constrainCenterY(to: target)]
    }
    
    @discardableResult
    public func constrain(to target: LayoutItem) -> [NSLayoutConstraint]
    {
        [ constrainTop(to: target),
          constrainBottom(to: target),
          constrainLeft(to: target),
          constrainRight(to: target) ]
    }
}
