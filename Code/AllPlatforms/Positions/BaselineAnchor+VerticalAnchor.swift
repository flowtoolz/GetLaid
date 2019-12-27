#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension BaselineAnchor
{
    @discardableResult
    func constrain(to target: VerticalTarget?) -> NSLayoutConstraint?
    {
        target.map
        {
            constrain(to: $0.anchor, offset: $0.offset, relation: $0.relation)
        }
    }
    
    @discardableResult
    func constrain(to targetAnchor: VerticalAnchor,
                   offset: CGFloat,
                   relation: Relation) -> NSLayoutConstraint
    {
        switch relation
        {
        case .exact:
            return nsAnchor.constraint(equalTo: targetAnchor.nsAnchor,
                                       constant: offset).activate()
        case .minimum:
            return nsAnchor.constraint(greaterThanOrEqualTo: targetAnchor.nsAnchor,
                                       constant: offset).activate()
        case .maximum:
            return nsAnchor.constraint(lessThanOrEqualTo: targetAnchor.nsAnchor,
                                       constant: offset).activate()
        case .relative(let factor):
            return NSLayoutConstraint(item: view,
                                      attribute: baseline.attribute,
                                      relatedBy: .equal,
                                      toItem: targetAnchor.item,
                                      attribute: targetAnchor.position.attribute,
                                      multiplier: factor,
                                      constant: offset).activate()
        }
    }
}