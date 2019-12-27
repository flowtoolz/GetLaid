#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension VerticalAnchor
{
    @discardableResult
    func constrain(to target: VerticalTarget?) -> NSLayoutConstraint?
    {
        target.map
        {
            constrain(to: $0.anchor, offset: $0.offset, relation: $0.relation)
        }
    }
    
    @discardableResult
    func constrain(to targetAnchor: VerticalAnchor,
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
    let offset: CGFloat
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
