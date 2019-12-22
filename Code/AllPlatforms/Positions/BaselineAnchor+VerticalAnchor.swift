#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    @discardableResult
    func constrain(_ baseline: Baseline, to target: VerticalTarget?) -> NSLayoutConstraint?
    {
        guard let target = target else { return nil }
        let sourceAnchor = BaselineAnchor(view: self, baseline: baseline)
        return sourceAnchor.constrain(to: target.anchor,
                                      offset: target.offset,
                                      relation: target.relation)
    }
}

extension BaselineAnchor
{
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
