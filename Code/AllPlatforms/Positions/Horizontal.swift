#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension HorizontalAnchor
{
    @discardableResult
    func constrain(to target: HorizontalTarget?) -> NSLayoutConstraint?
    {
        target.map
        {
            constrain(to: $0.anchor, offset: $0.offset, relation: $0.relation)
        }
    }
    
    @discardableResult
    func constrain(to target: HorizontalAnchor,
                   offset: CGFloat = 0,
                   relation: Relation = .exact) -> NSLayoutConstraint
    {
        switch relation
        {
        case .exact:
            return nsAnchor.constraint(equalTo: target.nsAnchor,
                                       constant: offset).activate()
        case .minimum:
            return nsAnchor.constraint(greaterThanOrEqualTo: target.nsAnchor,
                                       constant: offset).activate()
        case .maximum:
            return nsAnchor.constraint(lessThanOrEqualTo: target.nsAnchor,
                                       constant: offset).activate()
        case .relative(let factor):
            return NSLayoutConstraint(item: item,
                                      attribute: position.attribute,
                                      relatedBy: .equal,
                                      toItem: target.item,
                                      attribute: target.position.attribute,
                                      multiplier: factor,
                                      constant: offset).activate()
        }
    }
    
    func offset(_ offset: CGFloat) -> HorizontalTarget
    {
        .init(anchor: self, offset: offset)
    }
    
    var min: HorizontalTarget
    {
        .init(anchor: self, relation: .minimum)
    }
    
    var max: HorizontalTarget
    {
        .init(anchor: self, relation: .maximum)
    }
    
    func at(_ factor: CGFloat) -> HorizontalTarget
    {
        .init(anchor: self, relation: .relative(factor))
    }
}

public struct HorizontalTarget: Target
{
    init(anchor: HorizontalAnchor,
         offset: CGFloat = 0,
         relation: Relation = .exact)
    {
        self.anchor = anchor
        self.offset = offset
        self.relation = relation
    }
    
    let anchor: HorizontalAnchor
    let offset: CGFloat
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