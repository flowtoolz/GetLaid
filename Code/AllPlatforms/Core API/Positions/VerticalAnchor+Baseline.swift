#if os(OSX)
import AppKit
#else
import UIKit
#endif

@discardableResult
public func >>(anchor: VerticalAnchor, target: BaselineTarget?) -> NSLayoutConstraint?
{
    anchor.constrain(to: target)
}

@discardableResult
public func >>(anchor: VerticalAnchor, anchor2: BaselineAnchor?) -> NSLayoutConstraint?
{
    anchor.constrain(to: anchor2)
}

public extension VerticalAnchor
{
    @discardableResult
    func constrain(to anchor: BaselineAnchor?) -> NSLayoutConstraint?
    {
        guard let anchor = anchor else { return nil }
        return constrain(to: BaselineTarget(anchor))
    }
    
    @discardableResult
    func constrain(to target: BaselineTarget?) -> NSLayoutConstraint?
    {
        guard let target = target else { return nil }
        return constrain(to: target.anchor,
                         offset: target.offset,
                         relation: target.relation)
    }
    
    internal func constrain(to anchor: BaselineAnchor,
                            offset: CGFloat,
                            relation: Relation) -> NSLayoutConstraint
    {
        switch relation
        {
        case .exact:
            return nsAnchor.constraint(equalTo: anchor.nsAnchor,
                                       constant: offset).activate()
        case .minimum:
            return nsAnchor.constraint(greaterThanOrEqualTo: anchor.nsAnchor,
                                       constant: offset).activate()
        case .maximum:
            return nsAnchor.constraint(lessThanOrEqualTo: anchor.nsAnchor,
                                       constant: offset).activate()
        case .relative(let factor):
            return NSLayoutConstraint(item: item,
                                      attribute: position.attribute,
                                      relatedBy: .equal,
                                      toItem: anchor.view,
                                      attribute: anchor.baseline.attribute,
                                      multiplier: factor,
                                      constant: offset).activate()
        }
    }
}
