#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension LayoutItem
{
    @discardableResult
    public func constrainSize(to width: CGFloat,
                              _ height: CGFloat) -> [NSLayoutConstraint]
    {
        [constrainWidth(to: width), constrainHeight(to: height)]
    }
    
    @discardableResult
    public func constrainSize(to target: LayoutItem) -> [NSLayoutConstraint]
    {
        [constrainWidth(to: target), constrainHeight(to: target)]
    }
    
    @discardableResult
    public func constrainSize(to relativeWidth: CGFloat,
                              _ relativeHeight: CGFloat,
                              of target: LayoutItem) -> [NSLayoutConstraint]
    {
        [ constrainWidth(to: relativeWidth, of: target),
          constrainHeight(to: relativeHeight, of: target) ]
    }
    
    @discardableResult
    func constrain(_ dimension: Dimension,
                   to size: CGFloat) -> NSLayoutConstraint
    {
        let myAnchor = anchor(for: dimension)
        
        let constraint = myAnchor.constraint(equalToConstant: size)
        
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func constrain(_ dimension: Dimension,
                   toMinimum minimum: CGFloat) -> NSLayoutConstraint
    {
        let myAnchor = anchor(for: dimension)
        
        let constraint = myAnchor.constraint(greaterThanOrEqualToConstant: minimum)
        
        constraint.isActive = true
        
        return constraint
    }

    @discardableResult
    func constrain(_ dimension: Dimension,
                   toMaximum maximum: CGFloat) -> NSLayoutConstraint
    {
        let myAnchor = anchor(for: dimension)
        
        let constraint = myAnchor.constraint(lessThanOrEqualToConstant: maximum)
        
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func constrain(_ dimension: Dimension,
                   to target: LayoutItem,
                   multiplier: CGFloat = 1) -> NSLayoutConstraint
    {
        constrain(dimension, to: dimension, of: target, multiplier: multiplier)
    }
    
    @discardableResult
    func constrain(_ dimension: Dimension,
                   to targetDimension: Dimension,
                   of target: LayoutItem,
                   multiplier: CGFloat = 1) -> NSLayoutConstraint
    {
        let myAnchor = anchor(for: dimension)
        let targetAnchor = target.anchor(for: targetDimension)
        
        let constraint = myAnchor.constraint(equalTo: targetAnchor,
                                             multiplier: multiplier)
        
        constraint.isActive = true
        
        return constraint
    }
    
    func anchor(for dimension: Dimension) -> NSLayoutDimension
    {
        dimension == .width ? widthAnchor : heightAnchor
    }
}

enum Dimension { case width, height }
