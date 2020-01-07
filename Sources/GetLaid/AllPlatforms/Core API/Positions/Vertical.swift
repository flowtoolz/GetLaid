#if os(OSX)
import AppKit
#else
import UIKit
#endif

// MARK: - Constrain LayoutItem

@discardableResult
public func >>(item: LayoutItem, target: VerticalTarget?) -> NSLayoutConstraint?
{
    item.constrain(to: target)
}

@discardableResult
public func >>(item: LayoutItem, anchor: VerticalAnchor?) -> NSLayoutConstraint?
{
    item.constrain(to: anchor)
}

public extension LayoutItem
{
    @discardableResult
    func constrain(to target: VerticalTarget?) -> NSLayoutConstraint?
    {
        guard let target = target else { return nil }
        return VerticalAnchor(item: self,
                              position: target.anchor.position).constrain(to: target)
    }
    
    @discardableResult
    func constrain(to anchor: VerticalAnchor?) -> NSLayoutConstraint?
    {
        guard let anchor = anchor else { return nil }
        return VerticalAnchor(item: self,
                              position: anchor.position).constrain(to: anchor)
    }
}

// MARK: - Constrain VerticalAnchor

@discardableResult
public func >>(anchor: VerticalAnchor, item: LayoutItem?) -> NSLayoutConstraint?
{
    anchor.constrain(to: item)
}

@discardableResult
public func >>(anchor: VerticalAnchor, target: VerticalTarget?) -> NSLayoutConstraint?
{
    anchor.constrain(to: target)
}

@discardableResult
public func >>(anchor: VerticalAnchor, anchor2: VerticalAnchor?) -> NSLayoutConstraint?
{
    anchor.constrain(to: anchor2)
}

public extension VerticalAnchor
{
    @discardableResult
    func constrain(to item: LayoutItem?) -> NSLayoutConstraint?
    {
        guard let item = item else { return nil }
        return constrain(to: .init(item: item, position: position))
    }
    
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
            return NSLayoutConstraint(item: item,
                                      attribute: position.attribute,
                                      relatedBy: .equal,
                                      toItem: anchor.item,
                                      attribute: anchor.position.attribute,
                                      multiplier: factor,
                                      constant: offset).activate()
        }
    }
    
    func offset(_ offset: CGFloat) -> VerticalTarget
    {
        .init(self, offset: offset)
    }
    
    var min: VerticalTarget
    {
        .init(self, relation: .minimum)
    }
    
    var max: VerticalTarget
    {
        .init(self, relation: .maximum)
    }
    
    func at(_ factor: CGFloat) -> VerticalTarget
    {
        .init(self, relation: .relative(factor))
    }
}

// MARK: - Types

public struct VerticalTarget: Target
{
    init(_ anchor: VerticalAnchor,
         offset: CGFloat = 0,
         relation: Relation = .exact)
    {
        self.anchor = anchor
        self.offset = offset
        self.relation = relation
    }
    
    let anchor: VerticalAnchor
    
    public var offset: CGFloat = 0
    public var relation = Relation.exact
}

public extension LayoutItem
{
    var top: VerticalAnchor { anchor(for: .top) }
    var centerY: VerticalAnchor { anchor(for: .centerY) }
    var bottom: VerticalAnchor { anchor(for: .bottom) }
    
    func anchor(for position: VerticalPosition) -> VerticalAnchor
    {
        .init(item: self, position: position)
    }
}

public struct VerticalAnchor
{
    var nsAnchor: NSLayoutYAxisAnchor { item.nsAnchor(for: position) }
    let item: LayoutItem
    let position: VerticalPosition
}

extension LayoutItem
{
    func nsAnchor(for position: VerticalPosition) -> NSLayoutYAxisAnchor
    {
        switch position
        {
        case .top: return topAnchor
        case .centerY: return centerYAnchor
        case .bottom: return bottomAnchor
        }
    }
}

public enum VerticalPosition
{
    var attribute: LayoutAttribute
    {
        switch self
        {
        case .top: return .top
        case .centerY: return .centerY
        case .bottom: return .bottom
        }
    }
    
    case top, centerY, bottom
}
