#if os(OSX)
import AppKit
#else
import UIKit
#endif

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

public extension VerticalAnchor
{
    @discardableResult
    func constrain(to item: LayoutItem?) -> NSLayoutConstraint?
    {
        guard let item = item else { return nil }
        return constrain(to: .init(item: item, position: position))
    }
    
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
            return NSLayoutConstraint(item: item,
                                      attribute: position.attribute,
                                      relatedBy: .equal,
                                      toItem: targetAnchor.item,
                                      attribute: targetAnchor.position.attribute,
                                      multiplier: factor,
                                      constant: offset).activate()
        }
    }
    
    func offset(_ offset: CGFloat) -> VerticalTarget
    {
        .init(anchor: self, offset: offset)
    }
    
    var min: VerticalTarget
    {
        .init(anchor: self, relation: .minimum)
    }
    
    var max: VerticalTarget
    {
        .init(anchor: self, relation: .maximum)
    }
    
    func at(_ factor: CGFloat) -> VerticalTarget
    {
        .init(anchor: self, relation: .relative(factor))
    }
}

public struct VerticalTarget: Target
{
    init(anchor: VerticalAnchor,
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
