#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension LayoutChild
{
    // MARK: - Absolute Sizing
    
    @discardableResult
    public func constrainSizeToParent() -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [constrainWidth(to: parent), constrainHeight(to: parent) ]
    }
    
    @discardableResult
    public func constrainWidthToParent() -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainWidth(to: parent)
    }
    
    @discardableResult
    public func constrainHeightToParent() -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainHeight(to: parent)
    }
    
    // MARK: - Relative Sizing
    
    @discardableResult
    public func constrainWidthToParent(with relativeSize: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainWidth(to: relativeSize, of: parent)
    }
    
    @discardableResult
    public func constrainHeightToParent(with relativeSize: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainHeight(to: relativeSize, of: parent)
    }
    
    @discardableResult
    public func constrainSizeToParent(with relativeWidth: CGFloat,
                                      _ relativeHeight: CGFloat) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainWidth(to: relativeWidth, of: parent),
                 constrainHeight(to: relativeHeight, of: parent) ]
    }
}
