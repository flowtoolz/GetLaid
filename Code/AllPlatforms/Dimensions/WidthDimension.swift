#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
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

public extension LayoutItem
{
    // MARK: - To Absolute Points
    
    @discardableResult
    func constrainWidth(to size: CGFloat) -> NSLayoutConstraint
    {
        constrain(.width, to: size)
    }
    
    @discardableResult
    func constrainWidth(toMinimum minimum: CGFloat) -> NSLayoutConstraint
    {
        constrain(.width, toMinimum: minimum)
    }
    
    @discardableResult
    func constrainWidth(toMaximum maximum: CGFloat) -> NSLayoutConstraint
    {
        constrain(.width, toMaximum: maximum)
    }
    
    // MARK: - To Target
    
    @discardableResult
    func constrainWidth(to target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.width, to: target)
    }
    
    @discardableResult
    func constrainWidth(to factor: CGFloat,
                        of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.width, to: target, factor: factor)
    }
    
    // MARK: - To Height
    
    @discardableResult
    func constrainWidthToHeight(of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.width, to: .height, of: target)
    }
    
    @discardableResult
    func constrainAspectRatio(to ratio: CGFloat) -> NSLayoutConstraint
    {
        constrainWidth(to: ratio, ofHeightOf: self)
    }
    
    @discardableResult
    func constrainWidth(to factor: CGFloat,
                        ofHeightOf target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.width, to: .height, of: target, factor: factor)
    }
}
