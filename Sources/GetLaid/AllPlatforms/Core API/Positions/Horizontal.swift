#if os(OSX)
import AppKit
#else
import UIKit
#endif

// MARK: - Constrain LayoutItem

@discardableResult
public func >>(item: LayoutItem, target: HorizontalTarget?) -> NSLayoutConstraint?
{
    item.constrain(to: target)
}

@discardableResult
public func >>(item: LayoutItem, anchor: HorizontalAnchor?) -> NSLayoutConstraint?
{
    item.constrain(to: anchor)
}

public extension LayoutItem
{
    @discardableResult
    func constrain(to target: HorizontalTarget?) -> NSLayoutConstraint?
    {
        guard let target = target else { return nil }
        return HorizontalAnchor(item: self,
                                position: target.anchor.position).constrain(to: target)
    }
    
    @discardableResult
    func constrain(to anchor: HorizontalAnchor?) -> NSLayoutConstraint?
    {
        guard let anchor = anchor else { return nil }
        return HorizontalAnchor(item: self,
                                position: anchor.position).constrain(to: anchor)
    }
}

// MARK: - Constrain HorizontalAnchor

@discardableResult
public func >>(anchor: HorizontalAnchor, item: LayoutItem?) -> NSLayoutConstraint?
{
    anchor.constrain(to: item)
}

@discardableResult
public func >>(anchor: HorizontalAnchor, target: HorizontalTarget?) -> NSLayoutConstraint?
{
    anchor.constrain(to: target)
}

@discardableResult
public func >>(anchor: HorizontalAnchor, anchor2: HorizontalAnchor?) -> NSLayoutConstraint?
{
    anchor.constrain(to: anchor2)
}

public extension HorizontalAnchor
{
    @discardableResult
    func constrain(to item: LayoutItem?) -> NSLayoutConstraint?
    {
        guard let item = item else { return nil }
        return constrain(to: .init(item: item, position: position))
    }
    
    @discardableResult
    func constrain(to anchor: HorizontalAnchor?) -> NSLayoutConstraint?
    {
        guard let anchor = anchor else { return nil }
        return constrain(to: HorizontalTarget(anchor))
    }
    
    @discardableResult
    func constrain(to target: HorizontalTarget?) -> NSLayoutConstraint?
    {
        guard let target = target else { return nil }
        return constrain(to: target.anchor,
                         offset: target.offset,
                         relation: target.relation)
    }
    
    internal func constrain(to anchor: HorizontalAnchor,
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
    
    func offset(_ offset: CGFloat) -> HorizontalTarget
    {
        .init(self, offset: offset)
    }
    
    var min: HorizontalTarget
    {
        .init(self, relation: .minimum)
    }
    
    var max: HorizontalTarget
    {
        .init(self, relation: .maximum)
    }
    
    func at(_ factor: CGFloat) -> HorizontalTarget
    {
        .init(self, relation: .relative(factor))
    }
}

// MARK: - Types

public struct HorizontalTarget: Target
{
    init(_ anchor: HorizontalAnchor,
         offset: CGFloat = 0,
         relation: Relation = .exact)
    {
        self.anchor = anchor
        self.offset = offset
        self.relation = relation
    }
    
    let anchor: HorizontalAnchor
    
    public var offset: CGFloat = 0
    public var relation = Relation.exact
}

public extension LayoutItem
{
    var leading: HorizontalAnchor { anchor(for: .leading) }
    var centerX: HorizontalAnchor { anchor(for: .centerX) }
    var trailing: HorizontalAnchor { anchor(for: .trailing) }
    var left: HorizontalAnchor { anchor(for: .left) }
    var right: HorizontalAnchor { anchor(for: .right) }
    
    func anchor(for position: HorizontalPosition) -> HorizontalAnchor
    {
        .init(item: self, position: position)
    }
}

public struct HorizontalAnchor
{
    var nsAnchor: NSLayoutXAxisAnchor { item.nsAnchor(for: position) }
    let item: LayoutItem
    let position: HorizontalPosition
}

extension LayoutItem
{
    func nsAnchor(for position: HorizontalPosition) -> NSLayoutXAxisAnchor
    {
        switch position
        {
        case .leading: return leadingAnchor
        case .centerX: return centerXAnchor
        case .trailing: return trailingAnchor
        case .left: return leftAnchor
        case .right: return rightAnchor
        }
    }
}

public enum HorizontalPosition
{
    var attribute: LayoutAttribute
    {
        switch self
        {
        case .leading: return .leading
        case .centerX: return .centerX
        case .trailing: return .trailing
        case .left: return .left
        case .right: return .right
        }
    }
    
    case leading, centerX, trailing, left, right
}
