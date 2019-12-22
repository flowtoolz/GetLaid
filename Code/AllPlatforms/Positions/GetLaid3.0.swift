#if os(OSX)
import AppKit
#else
import UIKit
#endif

import Swift

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
    
    // MARK: - Constrain View to Single Baseline Target
    
    @discardableResult
    func constrain(to target: BaselineTarget?) -> NSLayoutConstraint? {
        guard let target = target else { return nil }
        return constrain(target.anchor.baseline, to: target)
    }
    
    // MARK: - Constrain Single Baseline to Target
    
    @discardableResult
    func constrain(_ baseline: Baseline, to target: BaselineTarget?) -> NSLayoutConstraint? {
        guard let target = target else { return nil }
        let sourceAnchor = BaselineAnchor(view: self, baseline: baseline)
        return sourceAnchor.constrain(to: target.anchor,
                                      offset: target.offset,
                                      relation: target.relation)
    }
    
    @discardableResult
    func constrain(_ baseline: Baseline, to target: VerticalTarget?) -> NSLayoutConstraint? {
        guard let target = target else { return nil }
        let sourceAnchor = BaselineAnchor(view: self, baseline: baseline)
        return sourceAnchor.constrain(to: target.anchor,
                                      offset: target.offset,
                                      relation: target.relation)
    }
    
    var firstBaseline: BaselineTarget { firstBaseline(offset: 0) }
    func firstBaseline(offset: CGFloat) -> BaselineTarget {
        .init(anchor: .init(view: self, baseline: .firstBaseline), offset: offset)
    }
    
    var lastBaseline: BaselineTarget { lastBaseline(offset: 0) }
    func lastBaseline(offset: CGFloat) -> BaselineTarget {
        .init(anchor: .init(view: self, baseline: .lastBaseline), offset: offset)
    }
}

public extension LayoutItem {
    
    // MARK: - Constrain Item to Multiple Targets
    
    @discardableResult
    func constrain(to item: LayoutItem?) -> [NSLayoutConstraint?] {
        constrain(to: item?.all)
    }
    
    @discardableResult
    func constrain(to targets: ItemPositionTargetCombination?) -> [NSLayoutConstraint?] {
        guard let targets = targets else { return [] }
        var constraints = [NSLayoutConstraint]()
        for verticalTarget in targets.verticalTargets {
            if let constraint = constrain(verticalTarget.anchor.position,
                                          to: verticalTarget) {
                constraints.append(constraint)
            }
        }
        for horizontalTarget in targets.horizontalTargets {
            if let constraint = constrain(horizontalTarget.anchor.position,
                                          to: horizontalTarget) {
                constraints.append(constraint)
            }
        }
        return constraints
    }
    
    var center: ItemPositionTargetCombination { center() }
    func center(xOffset: CGFloat = 0, yOffset: CGFloat = 0) -> ItemPositionTargetCombination {
        .init(horizontalTargets: [ .init(anchor: .init(item: self, position: .centerX),
                                         offset: xOffset) ],
              verticalTargets: [ .init(anchor: .init(item: self, position: .centerY),
                                       offset: yOffset) ])
    }
    
    var all: ItemPositionTargetCombination { all() }
    func all(topOffset: CGFloat = 0,
             leadingOffset: CGFloat = 0,
             bottomOffset: CGFloat = 0,
             trailingOffset: CGFloat = 0) -> ItemPositionTargetCombination {
        .init(horizontalTargets: [ .init(anchor: .init(item: self, position: .leading),
                                         offset: leadingOffset),
                                   .init(anchor: .init(item: self, position: .trailing),
                                         offset: trailingOffset) ],
              verticalTargets: [ .init(anchor: .init(item: self, position: .top),
                                       offset: topOffset),
                                 .init(anchor: .init(item: self, position: .bottom),
                                       offset: bottomOffset)])
    }
    
    func all(topOffset: CGFloat = 0,
             leftOffset: CGFloat,
             bottomOffset: CGFloat = 0,
             rightOffset: CGFloat) -> ItemPositionTargetCombination {
        .init(horizontalTargets: [ .init(anchor: .init(item: self, position: .left),
                                         offset: leftOffset),
                                   .init(anchor: .init(item: self, position: .right),
                                         offset: rightOffset) ],
              verticalTargets: [ .init(anchor: .init(item: self, position: .top),
                                       offset: topOffset),
                                 .init(anchor: .init(item: self, position: .bottom),
                                       offset: bottomOffset)])
    }
    
    var allButTop: ItemPositionTargetCombination { allButTop() }
    func allButTop(leadingOffset: CGFloat = 0,
                   bottomOffset: CGFloat = 0,
                   trailingOffset: CGFloat = 0) -> ItemPositionTargetCombination {
        .init(horizontalTargets: [ .init(anchor: .init(item: self, position: .leading),
                                         offset: leadingOffset),
                                   .init(anchor: .init(item: self, position: .trailing),
                                         offset: trailingOffset) ],
              verticalTargets: [ .init(anchor: .init(item: self, position: .bottom),
                                       offset: bottomOffset) ])
    }
    
    func allButTop(leftOffset: CGFloat,
                   bottomOffset: CGFloat = 0,
                   rightOffset: CGFloat) -> ItemPositionTargetCombination {
        .init(horizontalTargets: [ .init(anchor: .init(item: self, position: .left),
                                         offset: leftOffset),
                                   .init(anchor: .init(item: self, position: .right),
                                         offset: rightOffset) ],
              verticalTargets: [ .init(anchor: .init(item: self, position: .bottom),
                                       offset: bottomOffset) ])
    }
    
    var allButLeading: ItemPositionTargetCombination { allButLeading() }
    func allButLeading(topOffset: CGFloat = 0,
                       bottomOffset: CGFloat = 0,
                       trailingOffset: CGFloat = 0) -> ItemPositionTargetCombination {
        .init(horizontalTargets: [ .init(anchor: .init(item: self, position: .trailing),
                                         offset: trailingOffset) ],
              verticalTargets: [ .init(anchor: .init(item: self, position: .top),
                                       offset: topOffset),
                                 .init(anchor: .init(item: self, position: .bottom),
                                       offset: bottomOffset) ])
    }
    
    var allButBottom: ItemPositionTargetCombination { allButBottom() }
    func allButBottom(topOffset: CGFloat = 0,
                      leadingOffset: CGFloat = 0,
                      trailingOffset: CGFloat = 0) -> ItemPositionTargetCombination {
        .init(horizontalTargets: [ .init(anchor: .init(item: self, position: .leading),
                                         offset: leadingOffset),
                                   .init(anchor: .init(item: self, position: .trailing),
                                         offset: trailingOffset) ],
              verticalTargets: [ .init(anchor: .init(item: self, position: .top),
                                       offset: topOffset) ])
    }
    
    func allButBottom(topOffset: CGFloat = 0,
                      leftOffset: CGFloat,
                      rightOffset: CGFloat) -> ItemPositionTargetCombination {
        .init(horizontalTargets: [ .init(anchor: .init(item: self, position: .left),
                                         offset: leftOffset),
                                   .init(anchor: .init(item: self, position: .right),
                                         offset: rightOffset) ],
              verticalTargets: [ .init(anchor: .init(item: self, position: .top),
                                       offset: topOffset) ])
    }
    
    var allButTrailing: ItemPositionTargetCombination { allButTrailing() }
    func allButTrailing(topOffset: CGFloat = 0,
                        leadingOffset: CGFloat = 0,
                        bottomOffset: CGFloat = 0) -> ItemPositionTargetCombination {
        .init(horizontalTargets: [ .init(anchor: .init(item: self, position: .leading),
                                         offset: leadingOffset) ],
              verticalTargets: [ .init(anchor: .init(item: self, position: .top),
                                       offset: topOffset),
                                 .init(anchor: .init(item: self, position: .bottom),
                                       offset: bottomOffset) ])
    }
    
    var allButLeft: ItemPositionTargetCombination { allButLeft() }
    func allButLeft(topOffset: CGFloat = 0,
                    bottomOffset: CGFloat = 0,
                    rightOffset: CGFloat = 0) -> ItemPositionTargetCombination {
        .init(horizontalTargets: [ .init(anchor: .init(item: self, position: .right),
                                         offset: rightOffset) ],
              verticalTargets: [ .init(anchor: .init(item: self, position: .top),
                                       offset: topOffset),
                                 .init(anchor: .init(item: self, position: .bottom),
                                       offset: bottomOffset) ])
    }
    
    var allButRight: ItemPositionTargetCombination { allButRight() }
    func allButRight(topOffset: CGFloat = 0,
                     leftOffset: CGFloat = 0,
                     bottomOffset: CGFloat = 0) -> ItemPositionTargetCombination {
        .init(horizontalTargets: [ .init(anchor: .init(item: self, position: .left),
                                         offset: leftOffset) ],
              verticalTargets: [ .init(anchor: .init(item: self, position: .top),
                                       offset: topOffset),
                                 .init(anchor: .init(item: self, position: .bottom),
                                       offset: bottomOffset) ])
    }
    
    // MARK: - Constrain Item to Single Position Target
    
    @discardableResult
    func constrain(to target: HorizontalTarget?) -> NSLayoutConstraint? {
        guard let target = target else { return nil }
        return constrain(target.anchor.position, to: target)
    }
    
    @discardableResult
    func constrain(to target: VerticalTarget?) -> NSLayoutConstraint? {
        guard let target = target else { return nil }
        return constrain(target.anchor.position, to: target)
    }
    
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
    
    // MARK: - Constrain Single Position to Target
    
    @discardableResult
    func constrain(_ position: VerticalPosition,
                   to target: BaselineTarget?) -> NSLayoutConstraint? {
        guard let target = target else { return nil }
        let sourceAnchor = VerticalAnchor(item: self, position: position)
        return sourceAnchor.constrain(to: target.anchor,
                                      offset: target.offset,
                                      relation: target.relation)
    }
    
    @discardableResult
    func constrain(_ position: VerticalPosition,
                   to target: VerticalTarget?) -> NSLayoutConstraint? {
        guard let target = target else { return nil }
        let sourceAnchor = VerticalAnchor(item: self, position: position)
        return sourceAnchor.constrain(to: target.anchor,
                                      offset: target.offset,
                                      relation: target.relation)
    }
    
    @discardableResult
    func constrain(_ position: HorizontalPosition,
                   to target: HorizontalTarget?) -> NSLayoutConstraint? {
        guard let target = target else { return nil }
        let sourceAnchor = HorizontalAnchor(item: self, position: position)
        return sourceAnchor.constrain(to: target.anchor,
                                      offset: target.offset,
                                      relation: target.relation)
    }
    
    var leading: HorizontalTarget { leading(offset: 0) }
    func leading(offset: CGFloat) -> HorizontalTarget {
        .init(anchor: .init(item: self, position: .leading), offset: offset)
    }
    
    var centerX: HorizontalTarget { centerX(offset: 0) }
    func centerX(offset: CGFloat) -> HorizontalTarget {
        .init(anchor: .init(item: self, position: .centerX), offset: offset)
    }
    
    var trailing: HorizontalTarget { trailing(offset: 0) }
    func trailing(offset: CGFloat) -> HorizontalTarget {
        .init(anchor: .init(item: self, position: .trailing), offset: offset)
    }
    
    var left: HorizontalTarget { left(offset: 0) }
    func left(offset: CGFloat) -> HorizontalTarget {
        .init(anchor: .init(item: self, position: .left), offset: offset)
    }
    
    var right: HorizontalTarget { right(offset: 0) }
    func right(offset: CGFloat) -> HorizontalTarget {
        .init(anchor: .init(item: self, position: .right), offset: offset)
    }
    
    var top: VerticalTarget { top(offset: 0) }
    func top(offset: CGFloat) -> VerticalTarget {
        .init(anchor: .init(item: self, position: .top), offset: offset)
    }
    
    var centerY: VerticalTarget { centerY(offset: 0) }
    func centerY(offset: CGFloat) -> VerticalTarget {
        .init(anchor: .init(item: self, position: .centerY), offset: offset)
    }
    
    var bottom: VerticalTarget { bottom(offset: 0) }
    func bottom(offset: CGFloat) -> VerticalTarget {
        .init(anchor: .init(item: self, position: .bottom), offset: offset)
    }
}

public struct ItemPositionTargetCombination {
    let horizontalTargets: [HorizontalTarget]
    let verticalTargets: [VerticalTarget]
}
