#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    // MARK: - Constrain X Position to X Position
    
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
    
    // MARK: - Constrain X Position to Factor of X Position
    
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
