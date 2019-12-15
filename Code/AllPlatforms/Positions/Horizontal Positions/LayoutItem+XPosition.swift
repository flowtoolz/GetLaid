#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    // MARK: - Constrain X Position to X Position
    
    @discardableResult
    func constrain(_ position: XPosition,
                   to targetPosition: XPosition,
                   of target: LayoutItem,
                   offset: CGFloat = 0) -> NSLayoutConstraint
    {
        anchor(for: position).constraint(equalTo: target.anchor(for: targetPosition),
                                         constant: offset).activate()
    }
    
    @discardableResult
    func constrain(_ position: XPosition,
                   to targetPosition: XPosition,
                   of target: LayoutItem,
                   minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        anchor(for: position).constraint(greaterThanOrEqualTo: target.anchor(for: targetPosition),
                                         constant: minimumOffset).activate()
    }
    
    // MARK: - Constrain X Position to Factor of X Position
    
    @discardableResult
    func constrain(_ position: XPosition,
                   to factor: CGFloat,
                   of targetPosition: XPosition,
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
