#if os(OSX)
import AppKit
#else
import UIKit
#endif

@available(*, deprecated, message: "This convenience will be removed or reimplemented in the GetLaid core API")
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
        guard let parent = parent else { return nil }
        return height.constrain(to: parent.height, offset: 0, relation: relation)
    }
    
    @discardableResult
    func constrainToParentWidth(relation: Relation = .exact) -> NSLayoutConstraint?
    {
        guard let parent = parent else { return nil }
        return width.constrain(to: parent.width, offset: 0, relation: relation)
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
