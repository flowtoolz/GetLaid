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
        guard let parent = parent else { return [] }
        
        return [constrainWidth(to: parent), constrainHeight(to: parent) ]
    }
    
    @discardableResult
    func constrainWidthToParent() -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainWidth(to: parent)
    }
    
    @discardableResult
    func constrainHeightToParent() -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainHeight(to: parent)
    }
    
    // MARK: - Relative Sizing
    
    @discardableResult
    func constrainWidthToParent(with relativeSize: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainWidth(to: relativeSize, of: parent)
    }
    
    @discardableResult
    func constrainHeightToParent(with relativeSize: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainHeight(to: relativeSize, of: parent)
    }
    
    @discardableResult
    func constrainSizeToParent(with relativeWidth: CGFloat,
                               _ relativeHeight: CGFloat) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainWidth(to: relativeWidth, of: parent),
                 constrainHeight(to: relativeHeight, of: parent) ]
    }
}
