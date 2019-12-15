#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    // MARK: - Absolute Positioning - Baselines to View
    
    @discardableResult
    func constrainFirstBaseline(to target: LayoutView,
                                offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.firstBaseline, to: .firstBaseline, of: target, offset: offset)
    }
    
    @discardableResult
    func constrainFirstBaseline(to target: LayoutView,
                                minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.firstBaseline, to: .firstBaseline, of: target, minimumOffset: minimumOffset)
    }
    
    @discardableResult
    func constrainLastBaseline(to target: LayoutView,
                               offset: CGFloat = 0) -> NSLayoutConstraint
    {
        constrain(.lastBaseline, to: .lastBaseline, of: target, offset: offset)
    }
    
    @discardableResult
    func constrainLastBaseline(to target: LayoutView,
                               minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        constrain(.lastBaseline, to: .lastBaseline, of: target, minimumOffset: minimumOffset)
    }
    
    // MARK: - Relative Positioning - Baseline to Parent
    
    @discardableResult
    func constrainFirstBaselineToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrain(.firstBaseline, to: fraction, of: .bottom, of: parent)
    }

    @discardableResult
    func constrainLastBaselineToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        
        return constrain(.lastBaseline, to: fraction, of: .bottom, of: parent)
    }
    
    // MARK: - Relative Positioning - Baseline to Baseline
    
    @discardableResult
    func constrainFirstBaseline(to factor: CGFloat,
                                of targetBaseline: BaselinePosition = .firstBaseline,
                                of target: LayoutView) -> NSLayoutConstraint
    {
        constrain(.firstBaseline, to: factor, of: targetBaseline, of: target)
    }
    
    @discardableResult
    func constrainLastBaseline(to factor: CGFloat,
                               of targetBaseline: BaselinePosition = .lastBaseline,
                               of target: LayoutView) -> NSLayoutConstraint
    {
        constrain(.lastBaseline, to: factor, of: targetBaseline, of: target)
    }
    
    // MARK: - Relative Positioning - Baseline to Y Position
    
    @discardableResult
    func constrainFirstBaseline(to factor: CGFloat,
                                of targetPosition: YPosition,
                                of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.firstBaseline, to: factor, of: targetPosition, of: target)
    }
    
    @discardableResult
    func constrainLastBaseline(to factor: CGFloat,
                               of targetPosition: YPosition,
                               of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.lastBaseline, to: factor, of: targetPosition, of: target)
    }
    
    // MARK: - Constrain Baseline to Baseline
    
    @discardableResult
    func constrain(_ baseline: BaselinePosition,
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
    func constrain(_ baseline: BaselinePosition,
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
    func constrain(_ baseline: BaselinePosition,
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
    func constrain(_ baseline: BaselinePosition,
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
    
    // MARK: - Constrain Baseline to Factor of Position
    
    @discardableResult
    func constrain(_ baseline: BaselinePosition,
                   to factor: CGFloat,
                   of targetPosition: YPosition,
                   of target: LayoutItem) -> NSLayoutConstraint
    {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: baseline.attribute,
                                            relatedBy: .equal,
                                            toItem: target,
                                            attribute: targetPosition.attribute,
                                            multiplier: factor,
                                            constant: 0)
        
        constraint.isActive = true
        
        return constraint
    }
    
    // MARK: - Constrain Baseline to Factor of Baseline
    
    @discardableResult
    func constrain(_ baseline: BaselinePosition,
                   to factor: CGFloat,
                   of targetBaseline: BaselinePosition,
                   of target: LayoutView) -> NSLayoutConstraint
    {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: baseline.attribute,
                                            relatedBy: .equal,
                                            toItem: target,
                                            attribute: targetBaseline.attribute,
                                            multiplier: factor,
                                            constant: 0)
        
        constraint.isActive = true
        
        return constraint
    }
    
    // MARK: - Get Anchor for Baseline
    
    internal func anchor(for baselinePosition: BaselinePosition) -> NSLayoutYAxisAnchor
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
