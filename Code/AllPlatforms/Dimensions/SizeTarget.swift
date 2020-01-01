#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    @discardableResult
    func constrain(to sizeTarget: SizeTarget?) -> [NSLayoutConstraint]
    {
        guard let sizeTarget = sizeTarget else { return [] }
        
        switch sizeTarget.type
        {
        case .item(let item):
            let widthTarget = DimensionTarget(type: .anchor(.init(item: item,
                                                                  dimension: .width)),
                                              relation: sizeTarget.relation)
            let heightTarget = DimensionTarget(type: .anchor(.init(item: item,
                                                                   dimension: .height)),
                                               relation: sizeTarget.relation)
            return constrain(to: widthTarget) + constrain(to: heightTarget)
            
        case .size(let width, let height):
            let widthTarget = DimensionTarget(type: .size(width),
                                              relation: sizeTarget.relation)
            let heightTarget = DimensionTarget(type: .size(height),
                                               relation: sizeTarget.relation)
            return [self.width.constrain(to: widthTarget),
                    self.height.constrain(to: heightTarget)].compactMap { $0 }
        }
    }
    
    var size: SizeTarget
    {
        .init(type: .item(self), relation: .exact)
    }
}

public struct SizeTarget: Target
{
    public static func max(_ width: CGFloat, _ height: CGFloat) -> Self
    {
        size(width, height).max
    }
    
    public static func min(_ width: CGFloat, _ height: CGFloat) -> Self
    {
        size(width, height).min
    }
    
    public static func size(_ width: CGFloat, _ height: CGFloat) -> Self
    {
        .init(type: .size(width, height), relation: .exact)
    }
    
    let type: SizeTargetType
    
    enum SizeTargetType
    {
        case item(LayoutItem), size(CGFloat, CGFloat)
    }
    
    public var relation: Relation
}
