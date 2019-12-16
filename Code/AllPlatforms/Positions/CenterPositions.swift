#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    @discardableResult
    func constrainCenterToParent() -> [NSLayoutConstraint]
    {
        parent.map { constrainCenter(to: $0) } ?? []
    }
}

public extension LayoutItem
{
    @discardableResult
    func constrainCenter(to target: LayoutItem) -> [NSLayoutConstraint]
    {
        [constrainCenterX(to: target), constrainCenterY(to: target)]
    }
}
