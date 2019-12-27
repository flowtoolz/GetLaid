#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    @discardableResult
    func constrain(to target: BaselineTarget) -> NSLayoutConstraint?
    {
        BaselineAnchor(view: self,
                       baseline: target.anchor.baseline).constrain(to: target)
    }
    
    @discardableResult
    func constrain(to anchor: BaselineAnchor) -> NSLayoutConstraint
    {
        BaselineAnchor(view: self,
                       baseline: anchor.baseline).constrain(to: anchor)
    }
}

extension BaselineAnchor
{
    @discardableResult
    func constrain(to item: LayoutItem) -> NSLayoutConstraint
    {
        constrain(to: .init(view: view, baseline: baseline))
    }
    
    @discardableResult
    func constrain(to target: BaselineTarget?) -> NSLayoutConstraint?
    {
        target.map
        {
            constrain(to: $0.anchor, offset: $0.offset, relation: $0.relation)
        }
    }
    
    @discardableResult
    func constrain(to targetAnchor: BaselineAnchor,
                   offset: CGFloat = 0,
                   relation: Relation = .exact) -> NSLayoutConstraint
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
    
    func offset(_ offset: CGFloat) -> BaselineTarget
    {
        .init(anchor: self, offset: offset)
    }
    
    var min: BaselineTarget
    {
        .init(anchor: self, relation: .minimum)
    }
    
    var max: BaselineTarget
    {
        .init(anchor: self, relation: .maximum)
    }
    
    func at(_ factor: CGFloat) -> BaselineTarget
    {
        .init(anchor: self, relation: .relative(factor))
    }
}

public struct BaselineTarget: Target
{
    init(anchor: BaselineAnchor,
         offset: CGFloat = 0,
         relation: Relation = .exact)
    {
        self.anchor = anchor
        self.offset = offset
        self.relation = relation
    }
    
    let anchor: BaselineAnchor
    let offset: CGFloat
    public var relation = Relation.exact
}

extension LayoutView
{
    var firstBaseline: BaselineAnchor { anchor(for: .firstBaseline) }
    var lastBaseline: BaselineAnchor { anchor(for: .lastBaseline) }
    
    func anchor(for baseline: Baseline) -> BaselineAnchor
    {
        .init(view: self, baseline: baseline)
    }
}

public struct BaselineAnchor
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
