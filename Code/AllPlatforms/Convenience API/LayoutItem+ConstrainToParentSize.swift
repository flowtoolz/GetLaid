#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    @discardableResult
    func constrainToParentSize(relation: Relation = .exact) -> [NSLayoutConstraint]
    {
        constrain(to: parent?.size.with(relation))
    }
    
    @discardableResult
    func constrainToParentSize(at factor: CGFloat) -> [NSLayoutConstraint]
    {
        constrain(to: parent?.size.at(factor))
    }
    
    @discardableResult
    func constrainToParentHeight(relation: Relation = .exact) -> NSLayoutConstraint?
    {
        height.constrain(to: parent?.height, offset: 0, relation: relation)
    }
    
    @discardableResult
    func constrainToParentWidth(relation: Relation = .exact) -> NSLayoutConstraint?
    {
        width.constrain(to: parent?.width, offset: 0, relation: relation)
    }
    
    @discardableResult
    func constrainToParentHeight(at factor: CGFloat) -> [NSLayoutConstraint]
    {
        constrain(to: parent?.height.at(factor))
    }
    
    @discardableResult
    func constrainToParentWidth(at factor: CGFloat) -> [NSLayoutConstraint]
    {
        constrain(to: parent?.width.at(factor))
    }
}
