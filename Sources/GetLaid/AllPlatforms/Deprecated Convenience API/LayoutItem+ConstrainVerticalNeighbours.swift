#if os(OSX)
import AppKit
#else
import UIKit
#endif

@available(*, deprecated, message: "This convenience will be removed or reimplemented in the GetLaid core API")
public extension LayoutItem
{
    @discardableResult
    func constrain(above item: LayoutItem?, maxGap: CGFloat) -> [NSLayoutConstraint]
    {
        [ constrain(above: item, minGap: 0),
          bottom.constrain(to: item?.top.offset(-maxGap).min) ].compactMap { $0 }
    }
    
    @discardableResult
    func constrain(below item: LayoutItem?, maxGap: CGFloat) -> [NSLayoutConstraint]
    {
        [ constrain(below: item, minGap: 0),
          top.constrain(to: item?.bottom.offset(maxGap).max) ].compactMap { $0 }
    }
    
    @discardableResult
    func constrain(above item: LayoutItem?, minGap: CGFloat) -> NSLayoutConstraint?
    {
        bottom.constrain(to: item?.top.offset(-minGap).max)
    }
    
    @discardableResult
    func constrain(below item: LayoutItem?, minGap: CGFloat) -> NSLayoutConstraint?
    {
        top.constrain(to: item?.bottom.offset(minGap).min)
    }
    
    @discardableResult
    func constrain(above item: LayoutItem?, gap: CGFloat = 0) -> NSLayoutConstraint?
    {
        bottom.constrain(to: item?.top.offset(-gap))
    }
    
    @discardableResult
    func constrain(below item: LayoutItem?, gap: CGFloat = 0) -> NSLayoutConstraint?
    {
        top.constrain(to: item?.bottom.offset(gap))
    }
}
