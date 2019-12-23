#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    // MARK: - Constrain Item Next to Other Item - Maximum Gap
    
    @discardableResult
    func constrain(toTheRightOf item: LayoutItem?, maxGap: CGFloat) -> [NSLayoutConstraint?] {
        [ constrain(toTheRightOf: item, minGap: 0),
          constrain(.left, to: item?.right(offset: maxGap).max) ]
    }
    
    @discardableResult
    func constrain(toTheLeftOf item: LayoutItem?, maxGap: CGFloat) -> [NSLayoutConstraint?] {
        [ constrain(toTheLeftOf: item, minGap: 0),
          constrain(.right, to: item?.left(offset: -maxGap).min) ]
    }
    
    @discardableResult
    func constrain(after item: LayoutItem?, maxGap: CGFloat) -> [NSLayoutConstraint?] {
        [ constrain(after: item, minGap: 0),
          constrain(.leading, to: item?.trailing(offset: maxGap).max) ]
    }
    
    @discardableResult
    func constrain(before item: LayoutItem?, maxGap: CGFloat) -> [NSLayoutConstraint?] {
        [ constrain(before: item, minGap: 0),
          constrain(.trailing, to: item?.leading(offset: -maxGap).min) ]
    }
    
    // MARK: - Constrain Item Next to Other Item - Minimum Gap
    
    @discardableResult
    func constrain(toTheRightOf item: LayoutItem?, minGap: CGFloat) -> NSLayoutConstraint? {
        constrain(.left, to: item?.right(offset: minGap).min)
    }
    
    @discardableResult
    func constrain(toTheLeftOf item: LayoutItem?, minGap: CGFloat) -> NSLayoutConstraint? {
        constrain(.right, to: item?.left(offset: -minGap).max)
    }
    
    @discardableResult
    func constrain(after item: LayoutItem?, minGap: CGFloat) -> NSLayoutConstraint? {
        constrain(.leading, to: item?.trailing(offset: minGap).min)
    }
    
    @discardableResult
    func constrain(before item: LayoutItem?, minGap: CGFloat) -> NSLayoutConstraint? {
        constrain(.trailing, to: item?.leading(offset: -minGap).max)
    }
    
    // MARK: - Constrain Item Next to Other Item - Exact Gap
    
    @discardableResult
    func constrain(toTheRightOf item: LayoutItem?, gap: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(.left, to: item?.right(offset: gap))
    }
    
    @discardableResult
    func constrain(toTheLeftOf item: LayoutItem?, gap: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(.right, to: item?.left(offset: -gap))
    }
    
    @discardableResult
    func constrain(after item: LayoutItem?, gap: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(.leading, to: item?.trailing(offset: gap))
    }
    
    @discardableResult
    func constrain(before item: LayoutItem?, gap: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(.trailing, to: item?.leading(offset: -gap))
    }
    
    // MARK: - Other
    
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
