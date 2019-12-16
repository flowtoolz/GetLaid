#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
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
}
