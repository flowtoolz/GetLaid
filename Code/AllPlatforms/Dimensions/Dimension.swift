#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension DimensionAnchor
{
    func constrain(to target: DimensionTarget) -> NSLayoutConstraint
    {
        switch target.type
        {
        case .anchor(let anchor):
            return constrain(to: anchor, relation: target.relation)
        case .size(let constant):
            return constrain(to: constant, relation: target.relation)
        }
    }
    
    func constrain(to target: DimensionAnchor,
                   relation: Relation = .exact) -> NSLayoutConstraint
    {
        switch relation
        {
        case .exact:
            return nsDimension.constraint(equalTo: target.nsDimension).activate()
        case .minimum:
            return nsDimension.constraint(greaterThanOrEqualTo: target.nsDimension,
                                          multiplier: 1).activate()
        case .maximum:
            return nsDimension.constraint(lessThanOrEqualTo: target.nsDimension,
                                          multiplier: 1).activate()
        case .relative(let factor):
            return nsDimension.constraint(equalTo: target.nsDimension,
                                          multiplier: factor).activate()
        }
    }
    
    func constrain(to constant: CGFloat,
                   relation: Relation = .exact) -> NSLayoutConstraint
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
    static func anchor(item: LayoutItem,
                       dimension: Dimension,
                       relation: Relation = .exact) -> Self
    {
        .init(type: .anchor(.init(item: item, dimension: dimension)),
              relation: relation)
    }
    
    static func exact(_ constant: CGFloat) -> Self
    {
        .init(type: .size(constant))
    }
    
    static func max(_ constant: CGFloat) -> Self
    {
        .init(type: .size(constant), relation: .maximum)
    }
    
    static func min(_ constant: CGFloat) -> Self
    {
        .init(type: .size(constant), relation: .minimum)
    }
    
    let type: DimensionTargetType
    
    enum DimensionTargetType
    {
        case anchor(DimensionAnchor), size(CGFloat)
    }
    
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
