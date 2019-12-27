#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    // MARK: - Constrain Item Next to Other Item - Maximum Gap
    
    @discardableResult
    func constrain(toTheRightOf item: LayoutItem?, maxGap: CGFloat) -> [NSLayoutConstraint?]
    {
        [ constrain(toTheRightOf: item, minGap: 0),
          left.constrain(to: item?.right.offset(maxGap).max) ]
    }
    
    @discardableResult
    func constrain(toTheLeftOf item: LayoutItem?, maxGap: CGFloat) -> [NSLayoutConstraint?]
    {
        [ constrain(toTheLeftOf: item, minGap: 0),
          right.constrain(to: item?.left.offset(-maxGap).min) ]
    }
    
    @discardableResult
    func constrain(after item: LayoutItem?, maxGap: CGFloat) -> [NSLayoutConstraint?]
    {
        [ constrain(after: item, minGap: 0),
          leading.constrain(to: item?.trailing.offset(maxGap).max) ]
    }
    
    @discardableResult
    func constrain(before item: LayoutItem?, maxGap: CGFloat) -> [NSLayoutConstraint?]
    {
        [ constrain(before: item, minGap: 0),
          trailing.constrain(to: item?.leading.offset(-maxGap).min) ]
    }
    
    // MARK: - Constrain Item Next to Other Item - Minimum Gap
    
    @discardableResult
    func constrain(toTheRightOf item: LayoutItem?, minGap: CGFloat) -> NSLayoutConstraint?
    {
        left.constrain(to: item?.right.offset(minGap).min)
    }
    
    @discardableResult
    func constrain(toTheLeftOf item: LayoutItem?, minGap: CGFloat) -> NSLayoutConstraint?
    {
        right.constrain(to: item?.left.offset(-minGap).max)
    }
    
    @discardableResult
    func constrain(after item: LayoutItem?, minGap: CGFloat) -> NSLayoutConstraint?
    {
        leading.constrain(to: item?.trailing.offset(minGap).min)
    }
    
    @discardableResult
    func constrain(before item: LayoutItem?, minGap: CGFloat) -> NSLayoutConstraint?
    {
        trailing.constrain(to: item?.leading.offset(-minGap).max)
    }
    
    // MARK: - Constrain Item Next to Other Item - Exact Gap
    
    @discardableResult
    func constrain(toTheRightOf item: LayoutItem?, gap: CGFloat = 0) -> NSLayoutConstraint?
    {
        left.constrain(to: item?.right.offset(gap))
    }
    
    @discardableResult
    func constrain(toTheLeftOf item: LayoutItem?, gap: CGFloat = 0) -> NSLayoutConstraint?
    {
        right.constrain(to: item?.left.offset(-gap))
    }
    
    @discardableResult
    func constrain(after item: LayoutItem?, gap: CGFloat = 0) -> NSLayoutConstraint?
    {
        leading.constrain(to: item?.trailing.offset(gap))
    }
    
    @discardableResult
    func constrain(before item: LayoutItem?, gap: CGFloat = 0) -> NSLayoutConstraint?
    {
        trailing.constrain(to: item?.leading.offset(-gap))
    }
}
