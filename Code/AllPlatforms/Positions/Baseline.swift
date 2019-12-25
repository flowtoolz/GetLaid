#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    @discardableResult
    func constrain(to target: BaselineTarget?) -> NSLayoutConstraint?
    {
        guard let target = target else { return nil }
        return constrain(target.anchor.baseline, to: target)
    }
    
    @discardableResult
    func constrain(_ baseline: Baseline, to target: BaselineTarget?) -> NSLayoutConstraint?
    {
        guard let target = target else { return nil }
        let sourceAnchor = BaselineAnchor(view: self, baseline: baseline)
        return sourceAnchor.constrain(to: target.anchor,
                                      offset: target.offset,
                                      relation: target.relation)
    }
    
    var firstBaseline: BaselineTarget { firstBaseline(offset: 0) }
    
    func firstBaseline(offset: CGFloat) -> BaselineTarget
    {
        .init(anchor: .init(view: self, baseline: .firstBaseline), offset: offset)
    }
    
    var lastBaseline: BaselineTarget { lastBaseline(offset: 0) }
    
    func lastBaseline(offset: CGFloat) -> BaselineTarget
    {
        .init(anchor: .init(view: self, baseline: .lastBaseline), offset: offset)
    }
}

public struct BaselineTarget: Target
{
    let anchor: BaselineAnchor
    let offset: CGFloat
    public var relation = Relation.exact
}

extension BaselineAnchor
{
    func constrain(to targetAnchor: BaselineAnchor,
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
                                      toItem: targetAnchor.view,
                                      attribute: targetAnchor.baseline.attribute,
                                      multiplier: factor,
                                      constant: offset).activate()
        }
    }
}

struct BaselineAnchor
{
    var nsAnchor: NSLayoutYAxisAnchor { view.nsAnchor(for: baseline) }
    let view: LayoutView
    let baseline: Baseline
}

extension LayoutView
{
    func nsAnchor(for baseline: Baseline) -> NSLayoutYAxisAnchor
    {
        switch baseline
        {
        case .firstBaseline: return firstBaselineAnchor
        case .lastBaseline: return lastBaselineAnchor
        }
    }
}

public enum Baseline
{
    var attribute: LayoutAttribute
    {
        switch self
        {
        case .firstBaseline: return .firstBaseline
        case .lastBaseline: return .lastBaseline
        }
    }
    
    case firstBaseline, lastBaseline
}
