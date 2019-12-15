#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension LayoutItem
{
    // MARK: - Constrain Y Position to Y Position
    
    func constrain(_ position: YPosition,
                   to targetPosition: YPosition,
                   of target: LayoutItem,
                   offset: CGFloat = 0) -> NSLayoutConstraint
    {
        anchor(for: position).constraint(equalTo: target.anchor(for: targetPosition),
                                         constant: offset).activate()
    }
    
    func constrain(_ position: YPosition,
                   to targetPosition: YPosition,
                   of target: LayoutItem,
                   minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        anchor(for: position).constraint(greaterThanOrEqualTo: target.anchor(for: targetPosition),
                                         constant: minimumOffset).activate()
    }
    
    // MARK: - Constrain Y Position to Factor of Y Position
    
    func constrain(_ position: YPosition,
                   to factor: CGFloat,
                   of targetPosition: YPosition,
                   of target: LayoutItem) -> NSLayoutConstraint
    {
        NSLayoutConstraint(item: self,
                           attribute: position.attribute,
                           relatedBy: .equal,
                           toItem: target,
                           attribute: targetPosition.attribute,
                           multiplier: factor,
                           constant: 0).activate()
    }
}
