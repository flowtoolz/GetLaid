#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView {
    
    // MARK: - Constrain to Four Parent Edges 
    
    @discardableResult
    func constrainToParent(topInset: CGFloat = 0,
                           leadingInset: CGFloat = 0,
                           bottomInset: CGFloat = 0,
                           trailingInset: CGFloat = 0) -> [NSLayoutConstraint?] {
        [ constrainToParentTop(inset: topInset),
          constrainToParentLeading(inset: leadingInset),
          constrainToParentBottom(inset: bottomInset),
          constrainToParentTrailing(inset: trailingInset) ]
    }
    
    @discardableResult
    func constrainToParent(topInset: CGFloat = 0,
                           leftInset: CGFloat,
                           bottomInset: CGFloat = 0,
                           rightInset: CGFloat) -> [NSLayoutConstraint?] {
        [ constrainToParentTop(inset: topInset),
          constrainToParentLeft(inset: leftInset),
          constrainToParentBottom(inset: bottomInset),
          constrainToParentRight(inset: rightInset) ]
    }
    
    // MARK: - Constrain to Parent Center
    
    @discardableResult
    func constrainToParentCenter(xOffset: CGFloat = 0,
                                 yOffset: CGFloat = 0) -> [NSLayoutConstraint?] {
        [ constrainToParentCenterX(offset: xOffset),
          constrainToParentCenterY(offset: yOffset) ]
    }
    
    // MARK: - Constrain One Position to Parent - Factor
    
    @discardableResult
    func constrainTopToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        constrain(.top, to: parent?.bottom.at(factor))
    }
    
    @discardableResult
    func constrainLeadingToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        constrain(.leading, to: parent?.trailing.at(factor))
    }
    
    @discardableResult
    func constrainLeftToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        constrain(.left, to: parent?.right.at(factor))
    }
    
    @discardableResult
    func constrainCenterXToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        constrain(.centerX, to: parent?.trailing.at(factor))
    }
    
    @discardableResult
    func constrainCenterYToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        constrain(.centerY, to: parent?.bottom.at(factor))
    }
    
    @discardableResult
    func constrainBottomToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        constrain(.bottom, to: parent?.bottom.at(factor))
    }
    
    @discardableResult
    func constrainTrailingToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        constrain(.trailing, to: parent?.trailing.at(factor))
    }
    
    @discardableResult
    func constrainRightToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        constrain(.right, to: parent?.right.at(factor))
    }
    
    // MARK: - Constrain One Position to Parent - Inset/Offset
    
    @discardableResult
    func constrainToParentTop(inset: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(to: parent?.top(offset: inset))
    }
    
    @discardableResult
    func constrainToParentLeading(inset: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(to: parent?.leading(offset: inset))
    }
    
    @discardableResult
    func constrainToParentLeft(inset: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(to: parent?.left(offset: inset))
    }
    
    @discardableResult
    func constrainToParentCenterX(offset: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(to: parent?.centerX(offset: offset))
    }
    
    @discardableResult
    func constrainToParentCenterY(offset: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(to: parent?.centerY(offset: offset))
    }
    
    @discardableResult
    func constrainToParentBottom(inset: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(to: parent?.bottom(offset: -inset))
    }
    
    @discardableResult
    func constrainToParentTrailing(inset: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(to: parent?.trailing(offset: -inset))
    }
    
    @discardableResult
    func constrainToParentRight(inset: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(to: parent?.right(offset: -inset))
    }
}

public extension LayoutItem {
    
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
    
    @discardableResult
    func constrain(above item: LayoutItem?, maxGap: CGFloat) -> [NSLayoutConstraint?] {
        [ constrain(above: item, minGap: 0),
          constrain(.bottom, to: item?.top(offset: -maxGap).min) ]
    }
    
    @discardableResult
    func constrain(below item: LayoutItem?, maxGap: CGFloat) -> [NSLayoutConstraint?] {
        [ constrain(below: item, minGap: 0),
          constrain(.top, to: item?.bottom(offset: maxGap).max) ]
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
    
    @discardableResult
    func constrain(above item: LayoutItem?, minGap: CGFloat) -> NSLayoutConstraint? {
        constrain(.bottom, to: item?.top(offset: -minGap).max)
    }
    
    @discardableResult
    func constrain(below item: LayoutItem?, minGap: CGFloat) -> NSLayoutConstraint? {
        constrain(.top, to: item?.bottom(offset: minGap).min)
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
    
    @discardableResult
    func constrain(above item: LayoutItem?, gap: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(.bottom, to: item?.top(offset: -gap))
    }
    
    @discardableResult
    func constrain(below item: LayoutItem?, gap: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(.top, to: item?.bottom(offset: gap))
    }
}
