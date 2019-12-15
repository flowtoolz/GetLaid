#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    @discardableResult
    func constrainCenterXToParent(offset: CGFloat = 0) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainCenterX(to: parent, offset: offset)
    }
    
    @discardableResult
    func constrainCenterXToParent(minimumOffset: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainCenterX(to: parent, minimumOffset: minimumOffset)
    }
    
    @discardableResult
    func constrainCenterXToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainCenterX(to: fraction, of: .trailing, of: parent)
    }
}

public extension LayoutItem
{
    // MARK: - Offset
    
    @discardableResult
    func constrainCenterX(to target: LayoutItem,
                          offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.centerX, to: .centerX, of: target, offset: offset)
    }
    
    // MARK: - Minimum Offset
    
    @discardableResult
    func constrainCenterX(to target: LayoutItem,
                          minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.centerX, to: .centerX, of: target, minimumOffset: minimumOffset)
    }
    
    // MARK: - Factor
    
    @discardableResult
    func constrainCenterX(to factor: CGFloat,
                          of targetPosition: XPosition = .centerX,
                          of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.centerX, to: factor, of: targetPosition, of: target)
    }
}
