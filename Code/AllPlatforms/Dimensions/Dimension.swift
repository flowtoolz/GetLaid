#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    func constrain(_ dimension: Dimension,
                   toMinimum constant: CGFloat) -> NSLayoutConstraint
    {
        let sourceAnchor = DimensionAnchor(item: self, dimension: dimension)
        return sourceAnchor.constrain(to: constant, relation: .minimum)
    }

    func constrain(_ dimension: Dimension,
                   toMaximum constant: CGFloat) -> NSLayoutConstraint
    {
        let sourceAnchor = DimensionAnchor(item: self, dimension: dimension)
        return sourceAnchor.constrain(to: constant, relation: .maximum)
    }
    
    func constrain(_ dimension: Dimension,
                   to constant: CGFloat) -> NSLayoutConstraint
    {
        let sourceAnchor = DimensionAnchor(item: self, dimension: dimension)
        return sourceAnchor.constrain(to: constant, relation: .exact)
    }
    
    func constrain(to target: DimensionTarget) -> NSLayoutConstraint
    {
        constrain(target.anchor.dimension, to: target)
    }
    
    func constrain(_ dimension: Dimension,
                   to target: DimensionTarget) -> NSLayoutConstraint
    {
        let sourceAnchor = DimensionAnchor(item: self, dimension: dimension)
        return sourceAnchor.constrain(to: target.anchor, relation: target.relation)
    }
    
    var width: DimensionTarget
    {
        .init(anchor: .init(item: self, dimension: .width))
    }
    
    var height: DimensionTarget
    {
        .init(anchor: .init(item: self, dimension: .height))
    }
}

public struct DimensionTarget: Target
{
    let anchor: DimensionAnchor
    public var relation = Relation.exact
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
    
    func constrain(to constant: CGFloat, relation: Relation) -> NSLayoutConstraint
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
