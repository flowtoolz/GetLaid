#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    @discardableResult
    func constrain(above item: LayoutItem?, maxGap: CGFloat) -> [NSLayoutConstraint?] {
        [ constrain(above: item, minGap: 0),
          constrain(.bottom, to: item?.top(offset: -maxGap).min) ]
    }
    
    @discardableResult
    func constrain(below item: LayoutItem?, maxGap: CGFloat) -> [NSLayoutConstraint?] {
        [ constrain(below: item, minGap: 0),
          constrain(.top, to: item?.bottom(offset: maxGap).max) ]
    }
    
    @discardableResult
    func constrain(above item: LayoutItem?, minGap: CGFloat) -> NSLayoutConstraint? {
        constrain(.bottom, to: item?.top(offset: -minGap).max)
    }
    
    @discardableResult
    func constrain(below item: LayoutItem?, minGap: CGFloat) -> NSLayoutConstraint? {
        constrain(.top, to: item?.bottom(offset: minGap).min)
    }
    
    @discardableResult
    func constrain(above item: LayoutItem?, gap: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(.bottom, to: item?.top(offset: -gap))
    }
    
    @discardableResult
    func constrain(below item: LayoutItem?, gap: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(.top, to: item?.bottom(offset: gap))
    }
}
