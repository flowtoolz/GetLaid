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
    func constrain(to target: VerticalTarget?) -> NSLayoutConstraint?
    {
        guard let target = target else { return nil }
        return constrain(to: target.anchor,
                         offset: target.offset,
                         relation: target.relation)
    }
    
    @discardableResult
    func constrain(to targetAnchor: VerticalAnchor?,
                   offset: CGFloat = 0,
                   relation: Relation = .exact) -> NSLayoutConstraint?
    {
        guard let targetAnchor = targetAnchor else { return nil }
        
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