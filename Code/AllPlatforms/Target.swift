#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension Target
{
    var min: Self { with(.minimum) }
    var max: Self { with(.maximum) }
    
    func at(_ factor: CGFloat) -> Self { with(.relative(factor)) }
    
    func with(_ relation: Relation) -> Self
    {
        var copy = self
        copy.relation = relation
        return copy
    }
}

public protocol Target
{
    var relation: Relation { get set }
}
