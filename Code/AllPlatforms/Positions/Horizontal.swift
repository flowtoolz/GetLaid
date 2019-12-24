#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    @discardableResult
    func constrain(to target: HorizontalTarget?) -> NSLayoutConstraint? {
        guard let target = target else { return nil }
        return constrain(target.anchor.position, to: target)
    }
    
    @discardableResult
    func constrain(_ position: HorizontalPosition,
                   to target: HorizontalTarget?) -> NSLayoutConstraint?
    {
        guard let target = target else { return nil }
        let sourceAnchor = HorizontalAnchor(item: self, position: position)
        return sourceAnchor.constrain(to: target.anchor,
                                      offset: target.offset,
                                      relation: target.relation)
    }
    
    var leading: HorizontalTarget { leading(offset: 0) }
    
    func leading(offset: CGFloat) -> HorizontalTarget
    {
        .init(anchor: .init(item: self, position: .leading), offset: offset)
    }
    
    var centerX: HorizontalTarget { centerX(offset: 0) }
    
    func centerX(offset: CGFloat) -> HorizontalTarget
    {
        .init(anchor: .init(item: self, position: .centerX), offset: offset)
    }
    
    var trailing: HorizontalTarget { trailing(offset: 0) }
    
    func trailing(offset: CGFloat) -> HorizontalTarget
    {
        .init(anchor: .init(item: self, position: .trailing), offset: offset)
    }
    
    var left: HorizontalTarget { left(offset: 0) }
    
    func left(offset: CGFloat) -> HorizontalTarget
    {
        .init(anchor: .init(item: self, position: .left), offset: offset)
    }
    
    var right: HorizontalTarget { right(offset: 0) }
    
    func right(offset: CGFloat) -> HorizontalTarget
    {
        .init(anchor: .init(item: self, position: .right), offset: offset)
    }
}

public struct HorizontalTarget: PositionTarget
{
    let anchor: HorizontalAnchor
    let offset: CGFloat
    public var relation = Relation.exact
}

extension HorizontalAnchor
{
    func constrain(to targetAnchor: HorizontalAnchor,
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
            return NSLayoutConstraint(item: item,
                                      attribute: position.attribute,
                                      relatedBy: .equal,
                                      toItem: targetAnchor.item,
                                      attribute: targetAnchor.position.attribute,
                                      multiplier: factor,
                                      constant: offset).activate()
        }
    }
}

struct HorizontalAnchor
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
