#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    // MARK: - Position Items Next to Each Other - Via Left/Right
    
    @discardableResult
    func constrain(toTheLeftOf target: LayoutItem,
                   gap: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.right, to: .left, of: target, offset: -gap)
    }
    
    @discardableResult
    func constrain(toTheLeftOf target: LayoutItem,
                   minimumGap: CGFloat) -> NSLayoutConstraint
    {
        let constraint = rightAnchor.constraint(lessThanOrEqualTo: target.leftAnchor,
                                                constant: -minimumGap)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func constrain(toTheRightOf target: LayoutItem,
                   gap: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.left, to: .right, of: target, offset: gap)
    }
    
    @discardableResult
    func constrain(toTheRightOf target: LayoutItem,
                   minimumGap: CGFloat) -> NSLayoutConstraint
    {
        let constraint = leftAnchor.constraint(greaterThanOrEqualTo: target.rightAnchor,
                                               constant: minimumGap)
        constraint.isActive = true
        return constraint
    }
    
    // MARK: - Position Items Next to Each Other - Via Leading/Trailing
    
    @discardableResult
    func constrain(before target: LayoutItem,
                   gap: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.trailing, to: .leading, of: target, offset: -gap)
    }
    
    @discardableResult
    func constrain(before target: LayoutItem,
                   minimumGap: CGFloat) -> NSLayoutConstraint
    {
        let constraint = trailingAnchor.constraint(lessThanOrEqualTo: target.leadingAnchor,
                                                   constant: -minimumGap)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func constrain(after target: LayoutItem,
                   gap: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.leading, to: .trailing, of: target, offset: gap)
    }
    
    @discardableResult
    func constrain(after target: LayoutItem,
                   minimumGap: CGFloat) -> NSLayoutConstraint
    {
        let constraint = leadingAnchor.constraint(greaterThanOrEqualTo: target.trailingAnchor,
                                                  constant: minimumGap)
        constraint.isActive = true
        return constraint
    }
    
    // MARK: - Absolute Positioning
    
    @discardableResult
    func constrainLeft(to target: LayoutItem,
                       offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.left, to: .left, of: target, offset: offset)
    }
    
    @discardableResult
    func constrainLeft(to target: LayoutItem,
                       minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.left, to: .left, of: target, minimumOffset: minimumOffset)
    }
    
    @discardableResult
    func constrainRight(to target: LayoutItem,
                        offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.right, to: .right, of: target, offset: offset)
    }
    
    @discardableResult
    func constrainRight(to target: LayoutItem,
                        minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.right, to: .right, of: target, minimumOffset: minimumOffset)
    }
    
    @discardableResult
    func constrainCenterX(to target: LayoutItem,
                          offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.centerX, to: .centerX, of: target, offset: offset)
    }
    
    @discardableResult
    func constrainCenterX(to target: LayoutItem,
                          minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.centerX, to: .centerX, of: target, minimumOffset: minimumOffset)
    }
    
    @discardableResult
    func constrainLeading(to target: LayoutItem,
                          offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.leading, to: .leading, of: target, offset: offset)
    }
    
    @discardableResult
    func constrainLeading(to target: LayoutItem,
                          minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.leading, to: .leading, of: target, minimumOffset: minimumOffset)
    }
    
    @discardableResult
    func constrainTrailing(to target: LayoutItem,
                           offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.trailing, to: .trailing, of: target, offset: offset)
    }
    
    @discardableResult
    func constrainTrailing(to target: LayoutItem,
                           minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.trailing, to: .trailing, of: target, minimumOffset: minimumOffset)
    }
    
    @discardableResult
    func constrain(_ position: XPosition,
                   to targetPosition: XPosition,
                   of target: LayoutItem,
                   offset: CGFloat = 0) -> NSLayoutConstraint
    {
        let myAnchor = anchor(for: position)
        let targetAnchor = target.anchor(for: targetPosition)
        
        let constraint = myAnchor.constraint(equalTo: targetAnchor,
                                             constant: offset)
        
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func constrain(_ position: XPosition,
                   to targetPosition: XPosition,
                   of target: LayoutItem,
                   minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        let myAnchor = anchor(for: position)
        let targetAnchor = target.anchor(for: targetPosition)
        
        let constraint = myAnchor.constraint(greaterThanOrEqualTo: targetAnchor,
                                             constant: minimumOffset)
        
        constraint.isActive = true
        
        return constraint
    }
    
    internal func anchor(for xPosition: XPosition) -> NSLayoutXAxisAnchor
    {
        switch xPosition
        {
        case .left: return leftAnchor
        case .centerX: return centerXAnchor
        case .right: return rightAnchor
        case .leading: return leadingAnchor
        case .trailing: return trailingAnchor
        }
    }
    
    // MARK: - Relative Positioning
    
    @discardableResult
    func constrainLeft(to factor: CGFloat,
                       of targetPosition: XPosition = .left,
                       of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.left, to: factor, of: targetPosition, of: target)
    }
    
    @discardableResult
    func constrainRight(to factor: CGFloat,
                        of targetPosition: XPosition = .right,
                        of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.right, to: factor, of: targetPosition, of: target)
    }
    
    @discardableResult
    func constrainCenterX(to factor: CGFloat,
                          of targetPosition: XPosition = .centerX,
                          of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.centerX, to: factor, of: targetPosition, of: target)
    }
    
    @discardableResult
    func constrainLeading(to factor: CGFloat,
                          of targetPosition: XPosition = .leading,
                          of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.leading, to: factor, of: targetPosition, of: target)
    }
    
    @discardableResult
    func constrainTrailing(to factor: CGFloat,
                           of targetPosition: XPosition = .trailing,
                           of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.trailing, to: factor, of: targetPosition, of: target)
    }
    
    @discardableResult
    func constrain(_ position: XPosition,
                   to factor: CGFloat,
                   of targetPosition: XPosition,
                   of target: LayoutItem) -> NSLayoutConstraint
    {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: position.attribute,
                                            relatedBy: .equal,
                                            toItem: target,
                                            attribute: targetPosition.attribute,
                                            multiplier: factor,
                                            constant: 0)
        
        constraint.isActive = true
        
        return constraint
    }
}

public enum XPosition
{
    case left, centerX, right, leading, trailing
    
    var attribute: LayoutAttribute
    {
        switch self
        {
        case .leading: return .leading
        case .centerX: return .centerX
        case .trailing: return .trailing
        case .left: return .left
        case .right: return .right
        }
    }
}