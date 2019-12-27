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
                                          multiplier: 1)
        case .maximum:
            return nsDimension.constraint(lessThanOrEqualTo: target.nsDimension,
                                          multiplier: 1)
        case .relative(let factor):
            return nsDimension.constraint(equalTo: target.nsDimension,
                                          multiplier: factor)
        }
    }
    
    func constrain(to constant: CGFloat,
                   relation: Relation = .exact) -> NSLayoutConstraint
    {
        switch relation
        {
        case .exact:
            return nsDimension.constraint(equalToConstant: constant)
        case .minimum:
            return nsDimension.constraint(greaterThanOrEqualToConstant: constant)
        case .maximum:
            return nsDimension.constraint(lessThanOrEqualToConstant: constant)
        case .relative(let factor):
            return nsDimension.constraint(equalToConstant: factor * constant)
        }
    }
    
    func at(_ factor: CGFloat) -> DimensionTarget
    {
        .init(type: .anchor(self), relation: .relative(factor))
    }
    
    var max: DimensionTarget { .init(type: .anchor(self), relation: .maximum) }
    var min: DimensionTarget { .init(type: .anchor(self), relation: .minimum) }
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
    var width: DimensionAnchor
    {
        .init(item: self, dimension: .width)
    }
    
    var height: DimensionAnchor
    {
        .init(item: self, dimension: .height)
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
