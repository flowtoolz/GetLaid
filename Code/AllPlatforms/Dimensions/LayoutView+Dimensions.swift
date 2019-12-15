#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    // MARK: - Absolute Sizing
    
    @discardableResult
    func constrainSizeToParent() -> [NSLayoutConstraint]
    {
        parent.map { [constrainWidth(to: $0), constrainHeight(to: $0) ] } ?? []
    }
    
    @discardableResult
    func constrainWidthToParent() -> NSLayoutConstraint?
    {
        parent.map(constrainWidth(to:))
    }
    
    @discardableResult
    func constrainHeightToParent() -> NSLayoutConstraint?
    {
        parent.map(constrainHeight(to:))
    }
    
    // MARK: - Relative Sizing
    
    @discardableResult
    func constrainWidthToParent(with relativeSize: CGFloat) -> NSLayoutConstraint?
    {
        parent.map { constrainWidth(to: relativeSize, of: $0) }
    }
    
    @discardableResult
    func constrainHeightToParent(with relativeSize: CGFloat) -> NSLayoutConstraint?
    {
        parent.map { constrainHeight(to: relativeSize, of: $0) }
    }
    
    @discardableResult
    func constrainSizeToParent(with relativeWidth: CGFloat,
                               _ relativeHeight: CGFloat) -> [NSLayoutConstraint]
    {
        parent.map { [ constrainWidth(to: relativeWidth, of: $0),
                       constrainHeight(to: relativeHeight, of: $0) ] } ?? []
    }
}
