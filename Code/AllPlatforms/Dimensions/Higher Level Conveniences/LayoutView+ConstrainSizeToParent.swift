#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    @discardableResult
    func constrainSizeToParent() -> [NSLayoutConstraint]
    {
        parent.map { constrainSize(to: $0) } ?? []
    }
    
    @discardableResult
    func constrainSizeToParent(with relativeSize: CGFloat) -> [NSLayoutConstraint]
    {
        parent.map { constrainSize(to: relativeSize, of: $0) } ?? []
    }
    
    @discardableResult
    func constrainSizeToParent(with relativeWidth: CGFloat,
                               _ relativeHeight: CGFloat) -> [NSLayoutConstraint]
    {
        parent.map { constrainSize(to: relativeWidth, relativeHeight, of: $0) } ?? []
    }
}
