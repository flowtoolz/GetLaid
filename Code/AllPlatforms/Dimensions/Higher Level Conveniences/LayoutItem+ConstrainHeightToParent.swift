#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    @discardableResult
    func constrainHeightToParent() -> NSLayoutConstraint?
    {
        parent.map { constrain(to: $0.height) }
    }
    
    @discardableResult
    func constrainHeightToParent(with factor: CGFloat) -> [NSLayoutConstraint]?
    {
        parent.map { constrain(to: $0.height.at(factor)) }
    }
}
