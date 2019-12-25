#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    @discardableResult
    func constrain(to target: VerticalTarget?) -> NSLayoutConstraint? {
        guard let target = target else { return nil }
        return constrain(target.anchor.position, to: target)
    }
    
    @discardableResult
    func constrain(_ position: VerticalPosition,
                   to target: VerticalTarget?) -> NSLayoutConstraint?
    {
        guard let target = target else { return nil }
        let sourceAnchor = VerticalAnchor(item: self, position: position)
        return sourceAnchor.constrain(to: target.anchor,
                                      offset: target.offset,
                                      relation: target.relation)
    }
    
    var top: VerticalTarget { top(offset: 0) }
    
    func top(offset: CGFloat) -> VerticalTarget
    {
        .init(anchor: .init(item: self, position: .top), offset: offset)
    }
    
    var centerY: VerticalTarget { centerY(offset: 0) }
    
    func centerY(offset: CGFloat) -> VerticalTarget
    {
        .init(anchor: .init(item: self, position: .centerY), offset: offset)
    }
    
    var bottom: VerticalTarget { bottom(offset: 0) }
    
    func bottom(offset: CGFloat) -> VerticalTarget
    {
        .init(anchor: .init(item: self, position: .bottom), offset: offset)
    }
}

public struct VerticalTarget: Target
{
    let anchor: VerticalAnchor
    let offset: CGFloat
    public var relation = Relation.exact
}

extension VerticalAnchor
{
    func constrain(to targetAnchor: VerticalAnchor,
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

struct VerticalAnchor
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
