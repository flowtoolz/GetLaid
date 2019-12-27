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
        top.constrain(to: parent?.bottom.at(factor))
    }
    
    @discardableResult
    func constrainLeadingToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        leading.constrain(to: parent?.trailing.at(factor))
    }
    
    @discardableResult
    func constrainLeftToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        left.constrain(to: parent?.right.at(factor))
    }
    
    @discardableResult
    func constrainCenterXToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        centerX.constrain(to: parent?.trailing.at(factor))
    }
    
    @discardableResult
    func constrainCenterYToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        centerY.constrain(to: parent?.bottom.at(factor))
    }
    
    @discardableResult
    func constrainBottomToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        bottom.constrain(to: parent?.bottom.at(factor))
    }
    
    @discardableResult
    func constrainTrailingToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        trailing.constrain(to: parent?.trailing.at(factor))
    }
    
    @discardableResult
    func constrainRightToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        right.constrain(to: parent?.right.at(factor))
    }
    
    // MARK: - Constrain One Position to Parent - Inset/Offset
    
    @discardableResult
    func constrainToParentTop(inset: CGFloat = 0) -> NSLayoutConstraint? {
        top.constrain(to: parent?.top.offset(inset))
    }
    
    @discardableResult
    func constrainToParentLeading(inset: CGFloat = 0) -> NSLayoutConstraint? {
        leading.constrain(to: parent?.leading.offset(inset))
    }
    
    @discardableResult
    func constrainToParentLeft(inset: CGFloat = 0) -> NSLayoutConstraint? {
        left.constrain(to: parent?.left.offset(inset))
    }
    
    @discardableResult
    func constrainToParentCenterX(offset: CGFloat = 0) -> NSLayoutConstraint? {
        centerX.constrain(to: parent?.centerX.offset(offset))
    }
    
    @discardableResult
    func constrainToParentCenterY(offset: CGFloat = 0) -> NSLayoutConstraint? {
        centerY.constrain(to: parent?.centerY.offset(offset))
    }
    
    @discardableResult
    func constrainToParentBottom(inset: CGFloat = 0) -> NSLayoutConstraint? {
        bottom.constrain(to: parent?.bottom.offset(-inset))
    }
    
    @discardableResult
    func constrainToParentTrailing(inset: CGFloat = 0) -> NSLayoutConstraint? {
        trailing.constrain(to: parent?.trailing.offset(-inset))
    }
    
    @discardableResult
    func constrainToParentRight(inset: CGFloat = 0) -> NSLayoutConstraint? {
        right.constrain(to: parent?.right.offset(-inset))
    }
}