#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    @discardableResult
    func constrainCenterYToParent(offset: CGFloat = 0) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainCenterY(to: parent, offset: offset)
    }
    
    @discardableResult
    func constrainCenterYToParent(minimumOffset: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainCenterY(to: parent, minimumOffset: minimumOffset)
    }
    
    @discardableResult
    func constrainCenterYToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainCenterY(to: fraction, of: .bottom, of: parent)
    }
}

public extension LayoutItem
{
    @discardableResult
    func constrainCenterY(to target: LayoutItem,
                          offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.centerY, to: .centerY, of: target, offset: offset)
    }
    
    @discardableResult
    func constrainCenterY(to target: LayoutItem,
                          minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.centerY, to: .centerY, of: target, minimumOffset: minimumOffset)
    }
    
    @discardableResult
    func constrainCenterY(to factor: CGFloat,
                          of targetPosition: YPosition = .centerY,
                          of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.centerY, to: factor, of: targetPosition, of: target)
    }
}
