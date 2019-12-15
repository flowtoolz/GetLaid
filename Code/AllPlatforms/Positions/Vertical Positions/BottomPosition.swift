#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    @discardableResult
    func constrainBottomToParent(inset: CGFloat = 0) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainBottom(to: parent, offset: -inset)
    }
    
    @discardableResult
    func constrainBottomToParent(minimumInset: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        let constraint = bottomAnchor.constraint(lessThanOrEqualTo: parent.bottomAnchor,
                                                 constant: -minimumInset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func constrainBottomToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrainBottom(to: fraction, of: .bottom, of: parent)
    }
}

public extension LayoutItem
{
    // MARK: - Offset
    
    @discardableResult
    func constrain(above target: LayoutItem,
                   gap: CGFloat = 0) -> NSLayoutConstraint
    {
        constrainBottom(to: .top, of: target, offset: -gap)
    }
    
    @discardableResult
    func constrainBottom(to target: LayoutItem,
                         offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrainBottom(to: .bottom, of: target, offset: offset)
    }
    
    @discardableResult
    func constrainBottom(to targetPosition: YPosition,
                         of target: LayoutItem,
                         offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.bottom, to: targetPosition, of: target, offset: offset)
    }
    
    // MARK: - Minimum Offset
    
    @discardableResult
    func constrain(above target: LayoutItem,
                   minimumGap: CGFloat) -> NSLayoutConstraint
    {
        let constraint = bottomAnchor.constraint(lessThanOrEqualTo: target.topAnchor,
                                                 constant: -minimumGap)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func constrainBottom(to target: LayoutItem,
                         minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrainBottom(to: .bottom, of: target, minimumOffset: minimumOffset)
    }
    
    @discardableResult
    func constrainBottom(to targetPosition: YPosition,
                         of target: LayoutItem,
                         minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.bottom, to: targetPosition, of: target, minimumOffset: minimumOffset)
    }
    
    // MARK: - Factor
    
    @discardableResult
    func constrainBottom(to factor: CGFloat,
                         of targetPosition: YPosition = .bottom,
                         of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.bottom, to: factor, of: targetPosition, of: target)
    }
}
