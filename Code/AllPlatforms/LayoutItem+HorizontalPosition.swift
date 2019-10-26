#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    // MARK: - Absolute Positioning
    
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
    
    @discardableResult
    func constrainLeft(to target: LayoutItem,
                       offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.left, to: .left, of: target, offset: offset)
    }
    
    @discardableResult
    func constrainRight(to target: LayoutItem,
                        offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.right, to: .right, of: target, offset: offset)
    }
    
    @discardableResult
    func constrainCenterX(to target: LayoutItem,
                          offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.centerX, to: .centerX, of: target, offset: offset)
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
    
    func anchor(for xPosition: XPosition) -> NSLayoutXAxisAnchor
    {
        switch xPosition
        {
        case .left: return leftAnchor
        case .centerX: return centerXAnchor
        case .right: return rightAnchor
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
    case left, centerX, right
    
    var attribute: LayoutAttribute
    {
        switch self
        {
        case .left: return .left
        case .centerX: return .centerX
        case .right: return .right
        }
    }
}
