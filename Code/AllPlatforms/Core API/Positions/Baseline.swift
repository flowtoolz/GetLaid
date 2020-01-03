#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    @discardableResult
    func constrainToParentFirstBaseline(offset: CGFloat = 0) -> NSLayoutConstraint?
    {
        constrain(to: parent?.firstBaseline.offset(offset))
    }
    
    @discardableResult
    func constrainToParentLastBaseline(offset: CGFloat = 0) -> NSLayoutConstraint?
    {
        constrain(to: parent?.lastBaseline.offset(offset))
    }
    
    @discardableResult
    func constrain(to target: BaselineTarget?) -> NSLayoutConstraint?
    {
        guard let target = target else { return nil }
        return BaselineAnchor(view: self,
                              baseline: target.anchor.baseline).constrain(to: target)
    }
    
    @discardableResult
    func constrain(to anchor: BaselineAnchor?) -> NSLayoutConstraint?
    {
        guard let anchor = anchor else { return nil }
        return BaselineAnchor(view: self,
                              baseline: anchor.baseline).constrain(to: anchor)
    }
}

extension BaselineAnchor
{
    @discardableResult
    func constrain(to view: LayoutView?) -> NSLayoutConstraint?
    {
        guard let view = view else { return nil }
        return constrain(to: .init(view: view, baseline: baseline))
    }
    
    @discardableResult
    func constrain(to target: BaselineTarget?) -> NSLayoutConstraint?
    {
        guard let target = target else { return nil }
        return constrain(to: target.anchor,
                         offset: target.offset,
                         relation: target.relation)
    }
    
    @discardableResult
    func constrain(to targetAnchor: BaselineAnchor?,
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
    
    public var offset: CGFloat = 0
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
