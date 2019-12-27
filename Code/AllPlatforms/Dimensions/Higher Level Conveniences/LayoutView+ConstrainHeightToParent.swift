#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    @discardableResult
    func constrainHeightToParent() -> NSLayoutConstraint?
    {
        parent.map(constrainHeight(to:))
    }
    
    @discardableResult
    func constrainHeightToParent(with factor: CGFloat) -> NSLayoutConstraint?
    {
        parent.map { constrainHeight(to: factor, of: $0) }
    }
}
