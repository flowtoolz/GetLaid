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
        parent.map(constrainWidth(to:))
    }
    
    @discardableResult
    func constrainWidthToParent(with factor: CGFloat) -> NSLayoutConstraint?
    {
        parent.map { constrainWidth(to: factor, of: $0) }
    }
}
