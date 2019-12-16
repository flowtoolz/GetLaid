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
    
    // MARK: - Relative Positioning - Baseline to Parent
    
    @discardableResult
    func constrainFirstBaselineToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        parent.map { constrain(.firstBaseline, to: fraction, of: .bottom, of: $0) }
    }
    
    // MARK: - Relative Positioning - Baseline to Baseline
    
    @discardableResult
    func constrainFirstBaseline(to factor: CGFloat,
                                of targetBaseline: BaselinePosition = .firstBaseline,
                                of target: LayoutView) -> NSLayoutConstraint
    {
        constrain(.firstBaseline, to: factor, of: targetBaseline, of: target)
    }
    
    // MARK: - Relative Positioning - Baseline to Y Position
    
    @discardableResult
    func constrainFirstBaseline(to factor: CGFloat,
                                of targetPosition: YPosition,
                                of target: LayoutItem) -> NSLayoutConstraint
    {
        constrain(.firstBaseline, to: factor, of: targetPosition, of: target)
    }
}
