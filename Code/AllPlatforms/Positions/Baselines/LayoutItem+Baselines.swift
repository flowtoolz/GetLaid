#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    // MARK: - Absolute Positioning - Constrain Y Position to Baseline
    
    @discardableResult
    func constrain(_ yPosition: YPosition,
                   to targetBaseline: BaselinePosition,
                   of target: LayoutView,
                   offset: CGFloat = 0) -> NSLayoutConstraint
    {
        let myAnchor = anchor(for: yPosition)
        let targetAnchor = target.anchor(for: targetBaseline)
        
        let constraint = myAnchor.constraint(equalTo: targetAnchor,
                                             constant: offset)
        
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func constrain(_ yPosition: YPosition,
                   to targetBaseline: BaselinePosition,
                   of target: LayoutView,
                   minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        let myAnchor = anchor(for: yPosition)
        let targetAnchor = target.anchor(for: targetBaseline)
        
        let constraint = myAnchor.constraint(greaterThanOrEqualTo: targetAnchor,
                                             constant: minimumOffset)
        
        constraint.isActive = true
        
        return constraint
    }
    
    // MARK: - Relative Positioning - Y Position to Factor of Baseline
    
    @discardableResult
    func constrainTop(to factor: CGFloat,
                      of targetBaseline: BaselinePosition,
                      of target: LayoutView) -> NSLayoutConstraint
    {
        constrain(.top, to: factor, of: targetBaseline, of: target)
    }
    
    @discardableResult
    func constrainCenterY(to factor: CGFloat,
                          of targetBaseline: BaselinePosition,
                          of target: LayoutView) -> NSLayoutConstraint
    {
        constrain(.centerY, to: factor, of: targetBaseline, of: target)
    }
    
    @discardableResult
    func constrainBottom(to factor: CGFloat,
                         of targetBaseline: BaselinePosition,
                         of target: LayoutView) -> NSLayoutConstraint
    {
        constrain(.bottom, to: factor, of: targetBaseline, of: target)
    }
    
    @discardableResult
    func constrain(_ yPosition: YPosition,
                   to factor: CGFloat,
                   of targetBaseline: BaselinePosition,
                   of target: LayoutView) -> NSLayoutConstraint
    {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: yPosition.attribute,
                                            relatedBy: .equal,
                                            toItem: target,
                                            attribute: targetBaseline.attribute,
                                            multiplier: factor,
                                            constant: 0)
        
        constraint.isActive = true
        
        return constraint
    }
}
