#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    // MARK: - Absolute Positioning - Baselines to View
    
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
    func constrainLastBaselineToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        parent.map { constrain(.lastBaseline, to: fraction, of: .bottom, of: $0) }
    }
    
    // MARK: - Relative Positioning - Baseline to Baseline
   
    @discardableResult
    func constrainLastBaseline(to factor: CGFloat,
                               of targetBaseline: BaselinePosition = .lastBaseline,
                               of target: LayoutView) -> NSLayoutConstraint
    {
        constrain(.lastBaseline, to: factor, of: targetBaseline, of: target)
    }
    
    // MARK: - Relative Positioning - Baseline to Y Position
   
    @discardableResult
    func constrainLastBaseline(to factor: CGFloat,
                               of targetPosition: YPosition,
                               of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.lastBaseline, to: factor, of: targetPosition, of: target)
    }
}
