#if os(OSX)
import AppKit
#else
import UIKit
#endif

@discardableResult
public func >>(anchor: BaselineAnchor, target: VerticalTarget?) -> NSLayoutConstraint?
{
    anchor.constrain(to: target)
}

@discardableResult
public func >>(anchor: BaselineAnchor, anchor2: VerticalAnchor?) -> NSLayoutConstraint?
{
    anchor.constrain(to: anchor2)
}

public extension BaselineAnchor
{
    @discardableResult
    func constrain(to anchor: VerticalAnchor?) -> NSLayoutConstraint?
    {
        guard let anchor = anchor else { return nil }
        return constrain(to: VerticalTarget(anchor))
    }
    
    @discardableResult
    func constrain(to target: VerticalTarget?) -> NSLayoutConstraint?
    {
        guard let target = target else { return nil }
        return constrain(to: target.anchor,
                         offset: target.offset,
                         relation: target.relation)
    }
    
    internal func constrain(to anchor: VerticalAnchor,
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
            return NSLayoutConstraint(item: view,
                                      attribute: baseline.attribute,
                                      relatedBy: .equal,
                                      toItem: anchor.item,
                                      attribute: anchor.position.attribute,
                                      multiplier: factor,
                                      constant: offset).activate()
        }
    }
}
