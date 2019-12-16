#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    @discardableResult
    func constrainTop(to factor: CGFloat,
                      of targetBaseline: BaselinePosition,
                      of target: LayoutView) -> NSLayoutConstraint
    {
        constrain(.top, to: factor, of: targetBaseline, of: target)
    }
    
    @discardableResult
    func constrainCenterY(to factor: CGFloat,
                          of targetBaseline: BaselinePosition,
                          of target: LayoutView) -> NSLayoutConstraint
    {
        constrain(.centerY, to: factor, of: targetBaseline, of: target)
    }
    
    @discardableResult
    func constrainBottom(to factor: CGFloat,
                         of targetBaseline: BaselinePosition,
                         of target: LayoutView) -> NSLayoutConstraint
    {
        constrain(.bottom, to: factor, of: targetBaseline, of: target)
    }
}
