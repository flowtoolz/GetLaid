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
        parent.map { constrain(.firstBaseline, to: fraction, of: .bottom, of: $0) }
    }

    @discardableResult
    func constrainLastBaselineToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        parent.map { constrain(.lastBaseline, to: fraction, of: .bottom, of: $0) }
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
        anchor(for: baseline).constraint(equalTo: target.anchor(for: targetBaseline),
                                         constant: offset).activate()
    }
    
    @discardableResult
    func constrain(_ baseline: BaselinePosition,
                   to targetBaseline: BaselinePosition,
                   of target: LayoutView,
                   minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        anchor(for: baseline).constraint(greaterThanOrEqualTo: target.anchor(for: targetBaseline),
                                         constant: minimumOffset).activate()
    }
    
    // MARK: - Constrain Baseline to Y Position
    
    @discardableResult
    func constrain(_ baseline: BaselinePosition,
                   to targetPosition: YPosition,
                   of target: LayoutItem,
                   offset: CGFloat = 0) -> NSLayoutConstraint
    {
        anchor(for: baseline).constraint(equalTo: target.anchor(for: targetPosition),
                                         constant: offset).activate()
    }
    
    @discardableResult
    func constrain(_ baseline: BaselinePosition,
                   to targetPosition: YPosition,
                   of target: LayoutItem,
                   minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        anchor(for: baseline).constraint(greaterThanOrEqualTo: target.anchor(for: targetPosition),
                                         constant: minimumOffset).activate()
    }
    
    // MARK: - Constrain Baseline to Factor of Position
    
    @discardableResult
    func constrain(_ baseline: BaselinePosition,
                   to factor: CGFloat,
                   of targetPosition: YPosition,
                   of target: LayoutItem) -> NSLayoutConstraint
    {
        NSLayoutConstraint(item: self,
                           attribute: baseline.attribute,
                           relatedBy: .equal,
                           toItem: target,
                           attribute: targetPosition.attribute,
                           multiplier: factor,
                           constant: 0).activate()
    }
    
    // MARK: - Constrain Baseline to Factor of Baseline
    
    @discardableResult
    func constrain(_ baseline: BaselinePosition,
                   to factor: CGFloat,
                   of targetBaseline: BaselinePosition,
                   of target: LayoutView) -> NSLayoutConstraint
    {
        NSLayoutConstraint(item: self,
                           attribute: baseline.attribute,
                           relatedBy: .equal,
                           toItem: target,
                           attribute: targetBaseline.attribute,
                           multiplier: factor,
                           constant: 0).activate()
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
