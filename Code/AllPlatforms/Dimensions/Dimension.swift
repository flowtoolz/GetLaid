#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    func constrain(to target: DimensionTarget) -> [NSLayoutConstraint]
    {
        switch target.type
        {
        case .anchor(let anchor):
            return [constrain(anchor.dimension, to: target)]
        case .size(let constant):
            return [constrain(.width, to: .exact(constant)),
                    constrain(.height, to: .exact(constant))]
        }
    }
    
    func constrain(_ dimension: Dimension,
                   to target: DimensionTarget) -> NSLayoutConstraint
    {
        let sourceAnchor = DimensionAnchor(item: self, dimension: dimension)
        
        switch target.type
        {
        case .anchor(let anchor):
            return sourceAnchor.constrain(to: anchor, relation: target.relation)
        case .size(let constant):
            return sourceAnchor.constrain(to: constant, relation: target.relation)
        }
    }
    
    var width: DimensionTarget
    {
        .init(type: .anchor(.init(item: self, dimension: .width)))
    }
    
    var height: DimensionTarget
    {
        .init(type: .anchor(.init(item: self, dimension: .height)))
    }
}

public struct DimensionTarget: Target
{
    static func anchor(item: LayoutItem, dimension: Dimension) -> Self
    {
        .init(type: .anchor(.init(item: item, dimension: dimension)))
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
    public var relation = Relation.exact
    
    enum DimensionTargetType
    {
        case anchor(DimensionAnchor), size(CGFloat)
    }
}

extension DimensionAnchor
{
    func constrain(to target: DimensionAnchor,
                   relation: Relation) -> NSLayoutConstraint
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
                   relation: Relation) -> NSLayoutConstraint
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
