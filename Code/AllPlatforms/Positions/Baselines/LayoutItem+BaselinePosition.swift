#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{ 
    // MARK: - Constrain Y Position to Baseline
    
    // MARK: Offset
    
    @discardableResult
    func constrain(_ yPosition: YPosition,
                   to targetBaseline: BaselinePosition,
                   of target: LayoutView,
                   offset: CGFloat = 0) -> NSLayoutConstraint
    {
        anchor(for: yPosition).constraint(equalTo: target.anchor(for: targetBaseline),
                                          constant: offset).activate()
    }
    
    // MARK: Minimum Offset
    
    @discardableResult
    func constrain(_ yPosition: YPosition,
                   to targetBaseline: BaselinePosition,
                   of target: LayoutView,
                   minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        anchor(for: yPosition).constraint(greaterThanOrEqualTo: target.anchor(for: targetBaseline),
                                          constant: minimumOffset).activate()
    }
    
    // MARK: Factor
    
    @discardableResult
    func constrain(_ yPosition: YPosition,
                   to factor: CGFloat,
                   of targetBaseline: BaselinePosition,
                   of target: LayoutView) -> NSLayoutConstraint
    {
        NSLayoutConstraint(item: self,
                           attribute: yPosition.attribute,
                           relatedBy: .equal,
                           toItem: target,
                           attribute: targetBaseline.attribute,
                           multiplier: factor,
                           constant: 0).activate()
    }
}
