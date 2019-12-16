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

public extension LayoutItem
{
    @discardableResult
    func constrainSize(to width: CGFloat,
                       _ height: CGFloat) -> [NSLayoutConstraint]
    {
        [constrainWidth(to: width), constrainHeight(to: height)]
    }
    
    @discardableResult
    func constrainSize(to target: LayoutItem) -> [NSLayoutConstraint]
    {
        [constrainWidth(to: target), constrainHeight(to: target)]
    }
    
    @discardableResult
    func constrainSize(to relativeSize: CGFloat,
                       of target: LayoutItem) -> [NSLayoutConstraint]
    {
        constrainSize(to: relativeSize, relativeSize, of: target)
    }
    
    @discardableResult
    func constrainSize(to relativeWidth: CGFloat,
                       _ relativeHeight: CGFloat,
                       of target: LayoutItem) -> [NSLayoutConstraint]
    {
        [ constrainWidth(to: relativeWidth, of: target),
          constrainHeight(to: relativeHeight, of: target) ]
    }
}