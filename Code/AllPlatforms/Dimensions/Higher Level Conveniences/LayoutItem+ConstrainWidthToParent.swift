#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    @discardableResult
    func constrainWidthToParent() -> NSLayoutConstraint?
    {
        parent.map { constrain(to: $0.width) }
    }
    
    @discardableResult
    func constrainWidthToParent(with factor: CGFloat) -> [NSLayoutConstraint]?
    {
        parent.map { constrain(to: $0.width.at(factor)) }
    }
}
