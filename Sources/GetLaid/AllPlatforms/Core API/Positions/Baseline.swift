#if os(OSX)
import AppKit
#else
import UIKit
#endif

// MARK: - Constrain LayoutView

@discardableResult
public func >>(view: LayoutView, target: BaselineTarget?) -> NSLayoutConstraint?
{
    view.constrain(to: target)
}

@discardableResult
public func >>(view: LayoutView, anchor: BaselineAnchor?) -> NSLayoutConstraint?
{
    view.constrain(to: anchor)
}

public extension LayoutView
{
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

// MARK: - Constrain BaselineAnchor

@discardableResult
public func >>(anchor: BaselineAnchor, view: LayoutView?) -> NSLayoutConstraint?
{
    anchor.constrain(to: view)
}

@discardableResult
public func >>(anchor: BaselineAnchor, target: BaselineTarget?) -> NSLayoutConstraint?
{
    anchor.constrain(to: target)
}

@discardableResult
public func >>(anchor: BaselineAnchor, anchor2: BaselineAnchor?) -> NSLayoutConstraint?
{
    anchor.constrain(to: anchor2)
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
                            relation: Relation) -> NSLayoutConstraint?
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
                                      toItem: anchor.view,
                                      attribute: anchor.baseline.attribute,
                                      multiplier: factor,
                                      constant: offset).activate()
        }
    }
    
    func offset(_ offset: CGFloat) -> BaselineTarget
    {
        .init(self, offset: offset)
    }
    
    var min: BaselineTarget
    {
        .init(self, relation: .minimum)
    }
    
    var max: BaselineTarget
    {
        .init(self, relation: .maximum)
    }
    
    func at(_ factor: CGFloat) -> BaselineTarget
    {
        .init(self, relation: .relative(factor))
    }
}

// MARK: - Types

public struct BaselineTarget: Target
{
    init(_ anchor: BaselineAnchor,
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
