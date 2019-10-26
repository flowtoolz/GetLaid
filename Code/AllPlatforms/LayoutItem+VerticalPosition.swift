#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension LayoutItem
{
    // MARK: - Absolute Positioning
    
    @discardableResult
    public func constrain(above target: LayoutItem,
                          gap: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.bottom, to: .top, of: target, offset: -gap)
    }
    
    @discardableResult
    public func constrain(above target: LayoutItem,
                          minimumGap: CGFloat) -> NSLayoutConstraint
    {
        let constraint = bottomAnchor.constraint(lessThanOrEqualTo: target.topAnchor,
                                                 constant: -minimumGap)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func constrain(below target: LayoutItem,
                          gap: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.top, to: .bottom, of: target, offset: gap)
    }
    
    @discardableResult
    public func constrain(below target: LayoutItem,
                          minimumGap: CGFloat) -> NSLayoutConstraint
    {
        let constraint = topAnchor.constraint(greaterThanOrEqualTo: target.bottomAnchor,
                                              constant: minimumGap)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func constrainTop(to target: LayoutItem,
                             offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.top, to: .top, of: target, offset: offset)
    }
    
    @discardableResult
    public func constrainBottom(to target: LayoutItem,
                                offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.bottom, to: .bottom, of: target, offset: offset)
    }
    
    @discardableResult
    public func constrainCenterY(to target: LayoutItem,
                                 offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.centerY, to: .centerY, of: target, offset: offset)
    }
    
    @discardableResult
    public func constrain(_ position: YPosition,
                          to targetPosition: YPosition,
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
    
    func anchor(for yPosition: YPosition) -> NSLayoutYAxisAnchor
    {
        switch yPosition
        {
        case .top: return topAnchor
        case .centerY: return centerYAnchor
        case .bottom: return bottomAnchor
        }
    }
    
    // MARK: - Relative Positioning
    
    @discardableResult
    public func constrainTop(to factor: CGFloat,
                             of targetPosition: YPosition = .top,
                             of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.top, to: factor, of: targetPosition, of: target)
    }
    
    @discardableResult
    public func constrainBottom(to factor: CGFloat,
                                of targetPosition: YPosition = .bottom,
                                of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.bottom, to: factor, of: targetPosition, of: target)
    }
    
    @discardableResult
    public func constrainCenterY(to factor: CGFloat,
                                 of targetPosition: YPosition = .centerY,
                                 of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.centerY, to: factor, of: targetPosition, of: target)
    }
    
    @discardableResult
    func constrain(_ position: YPosition,
                   to factor: CGFloat,
                   of targetPosition: YPosition,
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

public enum YPosition
{
    case top, centerY, bottom
    
    var attribute: LayoutAttribute
    {
        switch self
        {
        case .top: return .top
        case .centerY: return .centerY
        case .bottom: return .bottom
        }
    }
}
