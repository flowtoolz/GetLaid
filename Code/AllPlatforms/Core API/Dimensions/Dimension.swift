#if os(OSX)
import AppKit
#else
import UIKit
#endif

// MARK: - Constrain Layout Item

@discardableResult
public func >>(item: LayoutItem, size: CGFloat) -> [NSLayoutConstraint]
{
    item.constrain(to: size)
}

@discardableResult
public func >>(item: LayoutItem, target: DimensionTarget?) -> [NSLayoutConstraint]
{
    item.constrain(to: target)
}

@discardableResult
public func >>(item: LayoutItem, anchor: DimensionAnchor?) -> NSLayoutConstraint?
{
    item.constrain(to: anchor)
}

public extension LayoutItem
{
    @discardableResult
    func constrain(to size: CGFloat) -> [NSLayoutConstraint]
    {
        constrain(to: .size(size))
    }
    
    @discardableResult
    func constrain(to target: DimensionTarget?) -> [NSLayoutConstraint]
    {
        guard let target = target else { return [] }
        
        switch target.type
        {
        case .size(let size):
            return [anchor(for: .width).constrain(to: size + target.offset,
                                                  relation: target.relation),
                    anchor(for: .height).constrain(to: size + target.offset,
                                                   relation: target.relation)]
        case .anchor(let targetAnchor):
            let sourceAnchor = DimensionAnchor(item: self,
                                               dimension: targetAnchor.dimension)
            return [sourceAnchor.constrain(to: targetAnchor,
                                           offset: target.offset,
                                           relation: target.relation)].compactMap { $0 }
        }
    }
    
    @discardableResult
    func constrain(to anchor: DimensionAnchor?) -> NSLayoutConstraint?
    {
        guard let anchor = anchor else { return nil }
        return DimensionAnchor(item: self,
                               dimension: anchor.dimension).constrain(to: anchor)
    }
}

// MARK: - Constrain DimensionAnchor

@discardableResult
public func >>(anchor: DimensionAnchor, item: LayoutItem?) -> NSLayoutConstraint?
{
    anchor.constrain(to: item)
}

@discardableResult
public func >>(anchor: DimensionAnchor, target: DimensionTarget?) -> NSLayoutConstraint?
{
    anchor.constrain(to: target)
}

@discardableResult
public func >>(anchor: DimensionAnchor, anchor2: DimensionAnchor?) -> NSLayoutConstraint?
{
    anchor.constrain(to: anchor2)
}

@discardableResult
public func >>(anchor: DimensionAnchor, size: CGFloat) -> NSLayoutConstraint
{
    anchor.constrain(to: size)
}

public extension DimensionAnchor
{
    @discardableResult
    func constrain(to item: LayoutItem?) -> NSLayoutConstraint?
    {
        guard let item = item else { return nil }
        return constrain(to: .init(item: item, dimension: dimension))
    }
    
    @discardableResult
    func constrain(to target: DimensionTarget?) -> NSLayoutConstraint?
    {
        guard let target = target else { return nil }
        
        switch target.type
        {
        case .anchor(let anchor):
            return constrain(to: anchor,
                             offset: target.offset,
                             relation: target.relation)
        case .size(let constant):
            return constrain(to: constant + target.offset,
                             relation: target.relation)
        }
    }
    
    @discardableResult
    func constrain(to anchor: DimensionAnchor?) -> NSLayoutConstraint?
    {
        constrain(to: anchor, offset: 0, relation: .exact)
    }
    
    @discardableResult
    func constrain(to size: CGFloat) -> NSLayoutConstraint
    {
        constrain(to: size, relation: .exact)
    }
    
    internal func constrain(to target: DimensionAnchor?,
                            offset: CGFloat,
                            relation: Relation) -> NSLayoutConstraint?
    {
        guard let target = target else { return nil }
        
        switch relation
        {
        case .exact:
            return nsDimension.constraint(equalTo: target.nsDimension,
                                          multiplier: 1,
                                          constant: offset).activate()
        case .minimum:
            return nsDimension.constraint(greaterThanOrEqualTo: target.nsDimension,
                                          multiplier: 1,
                                          constant: offset).activate()
        case .maximum:
            return nsDimension.constraint(lessThanOrEqualTo: target.nsDimension,
                                          multiplier: 1,
                                          constant: offset).activate()
        case .relative(let factor):
            return nsDimension.constraint(equalTo: target.nsDimension,
                                          multiplier: factor,
                                          constant: offset).activate()
        }
    }
    
    internal func constrain(to constant: CGFloat,
                            relation: Relation) -> NSLayoutConstraint
    {
        switch relation
        {
        case .exact:
            return nsDimension.constraint(equalToConstant: constant).activate()
        case .minimum:
            return nsDimension.constraint(greaterThanOrEqualToConstant: constant).activate()
        case .maximum:
            return nsDimension.constraint(lessThanOrEqualToConstant: constant).activate()
        case .relative(let factor):
            return nsDimension.constraint(equalToConstant: factor * constant).activate()
        }
    }
    
    func offset(_ offset: CGFloat) -> DimensionTarget
    {
        .init(type: .anchor(self), offset: offset)
    }
    
    var min: DimensionTarget
    {
        .init(type: .anchor(self), relation: .minimum)
    }
    
    var max: DimensionTarget
    {
        .init(type: .anchor(self), relation: .maximum)
    }
    
    func at(_ factor: CGFloat) -> DimensionTarget
    {
        .init(type: .anchor(self), relation: .relative(factor))
    }
}

public struct DimensionTarget: Target
{
    public static func max(_ constant: CGFloat) -> Self
    {
        size(constant).max
    }
    
    public static func min(_ constant: CGFloat) -> Self
    {
        size(constant).min
    }
    
    public static func size(_ constant: CGFloat) -> Self
    {
        .init(type: .size(constant))
    }

    let type: DimensionTargetType
    
    enum DimensionTargetType
    {
        case anchor(DimensionAnchor), size(CGFloat)
    }
    
    public var offset: CGFloat = 0
    public var relation = Relation.exact
}

public extension LayoutItem
{
    var width: DimensionAnchor { anchor(for: .width) }
    var height: DimensionAnchor { anchor(for: .height) }
    
    func anchor(for dimension: Dimension) -> DimensionAnchor
    {
        .init(item: self, dimension: dimension)
    }
}

public struct DimensionAnchor
{
    var nsDimension: NSLayoutDimension { item.nsDimension(for: dimension) }
    let item: LayoutItem
    let dimension: Dimension
}

extension LayoutItem
{
    func nsDimension(for dimension: Dimension) -> NSLayoutDimension
    {
        dimension == .width ? widthAnchor : heightAnchor
    }
}

public enum Dimension
{
    var attribute: LayoutAttribute
    {
        self == .width ? .width : .height
    }
    
    case width, height
}
