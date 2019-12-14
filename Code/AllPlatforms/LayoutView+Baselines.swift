#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    // MARK: - Constrain First Baseline to View
    
    @discardableResult
    public func constrainFirstBaseline(to target: LayoutView,
                                       offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.firstBaseline, to: .firstBaseline, of: target, offset: offset)
    }
    
    @discardableResult
    public func constrainFirstBaseline(to target: LayoutView,
                                       minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.firstBaseline, to: .firstBaseline, of: target, minimumOffset: minimumOffset)
    }
    
    // MARK: - Constrain Last Baseline to View
    
    @discardableResult
    public func constrainLastBaseline(to target: LayoutView,
                                      offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.lastBaseline, to: .lastBaseline, of: target, offset: offset)
    }
    
    @discardableResult
    public func constrainLastBaseline(to target: LayoutView,
                                      minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.lastBaseline, to: .lastBaseline, of: target, minimumOffset: minimumOffset)
    }
    
    // MARK: - Constrain Baseline to Baseline
    
    @discardableResult
    public func constrain(_ baseline: BaselinePosition,
                          to targetBaseline: BaselinePosition,
                          of target: LayoutView,
                          offset: CGFloat = 0) -> NSLayoutConstraint
    {
        let myAnchor = anchor(for: baseline)
        let targetAnchor = target.anchor(for: targetBaseline)
        
        let constraint = myAnchor.constraint(equalTo: targetAnchor,
                                             constant: offset)
        
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    public func constrain(_ baseline: BaselinePosition,
                          to targetBaseline: BaselinePosition,
                          of target: LayoutView,
                          minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        let myAnchor = anchor(for: baseline)
        let targetAnchor = target.anchor(for: targetBaseline)
        
        let constraint = myAnchor.constraint(greaterThanOrEqualTo: targetAnchor,
                                             constant: minimumOffset)
        
        constraint.isActive = true
        
        return constraint
    }
    
    // MARK: - Constrain Baseline to Y Position
    
    @discardableResult
    public func constrain(_ baseline: BaselinePosition,
                          to targetPosition: YPosition,
                          of target: LayoutItem,
                          offset: CGFloat = 0) -> NSLayoutConstraint
    {
        let myAnchor = anchor(for: baseline)
        let targetAnchor = target.anchor(for: targetPosition)
        
        let constraint = myAnchor.constraint(equalTo: targetAnchor,
                                             constant: offset)
        
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    public func constrain(_ baseline: BaselinePosition,
                          to targetPosition: YPosition,
                          of target: LayoutItem,
                          minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        let myAnchor = anchor(for: baseline)
        let targetAnchor = target.anchor(for: targetPosition)
        
        let constraint = myAnchor.constraint(greaterThanOrEqualTo: targetAnchor,
                                             constant: minimumOffset)
        
        constraint.isActive = true
        
        return constraint
    }
    
    // MARK: - Get Anchor for Baseline
    
    func anchor(for baselinePosition: BaselinePosition) -> NSLayoutYAxisAnchor
    {
        switch baselinePosition
        {
        case .firstBaseline: return firstBaselineAnchor
        case .lastBaseline: return lastBaselineAnchor
        }
    }
}

public enum BaselinePosition
{
    case firstBaseline, lastBaseline
    
    var attribute: LayoutAttribute
    {
        switch self
        {
        case .firstBaseline: return .firstBaseline
        case .lastBaseline: return .lastBaseline
        }
    }
}
