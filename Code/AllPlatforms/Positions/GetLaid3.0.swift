#if os(OSX)
import AppKit
#else
import UIKit
#endif

import Swift

public extension LayoutView {
    
    // MARK: - Constrain to Four Parent Edges 
    
    func constrainToParent(topInset: CGFloat = 0,
                           leadingInset: CGFloat = 0,
                           bottomInset: CGFloat = 0,
                           trailingInset: CGFloat = 0) -> [NSLayoutConstraint?] {
        [ constrainToParentTop(inset: topInset),
          constrainToParentLeading(inset: leadingInset),
          constrainToParentBottom(inset: bottomInset),
          constrainToParentTrailing(inset: trailingInset) ]
    }
    
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
    
    func constrainToParentCenter(xOffset: CGFloat = 0,
                                 yOffset: CGFloat = 0) -> [NSLayoutConstraint?] {
        [ constrainToParentCenterX(offset: xOffset),
          constrainToParentCenterY(offset: yOffset) ]
    }
    
    // MARK: - Constrain One Position to Parent - Factor
    
    func constrainTopToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        constrain(.top, to: parent?.bottom.at(factor))
    }
    
    func constrainLeadingToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        constrain(.leading, to: parent?.trailing.at(factor))
    }
    
    func constrainLeftToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        constrain(.left, to: parent?.right.at(factor))
    }
    
    func constrainCenterXToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        constrain(.centerX, to: parent?.trailing.at(factor))
    }
    
    func constrainCenterYToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        constrain(.centerY, to: parent?.bottom.at(factor))
    }
    
    func constrainBottomToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        constrain(.bottom, to: parent?.bottom.at(factor))
    }
    
    func constrainTrailingToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        constrain(.trailing, to: parent?.trailing.at(factor))
    }
    
    func constrainRightToParent(at factor: CGFloat) -> NSLayoutConstraint? {
        constrain(.right, to: parent?.right.at(factor))
    }
    
    // MARK: - Constrain One Position to Parent - Inset/Offset
    
    func constrainToParentTop(inset: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(to: parent?.top(offset: inset))
    }
    
    func constrainToParentLeading(inset: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(to: parent?.leading(offset: inset))
    }
    
    func constrainToParentLeft(inset: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(to: parent?.left(offset: inset))
    }
    
    func constrainToParentCenterX(offset: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(to: parent?.centerX(offset: offset))
    }
    
    func constrainToParentCenterY(offset: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(to: parent?.centerY(offset: offset))
    }
    
    func constrainToParentBottom(inset: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(to: parent?.bottom(offset: -inset))
    }
    
    func constrainToParentTrailing(inset: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(to: parent?.trailing(offset: -inset))
    }
    
    func constrainToParentRight(inset: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(to: parent?.right(offset: -inset))
    }
    
    // MARK: - Constrain View to Single Baseline Target
    
    func constrain(to target: BaselineTarget?) -> NSLayoutConstraint? {
        guard let target = target else { return nil }
        return constrain(target.anchor.baseline, to: target)
    }
    
    // MARK: - Constrain Single Baseline to Target
    
    func constrain(_ baseline: Baseline, to target: BaselineTarget?) -> NSLayoutConstraint? {
        guard let target = target else { return nil }
        return GetLaid.constrain(.init(view: self, baseline: baseline),
                          to: target.anchor,
                          offset: target.offset,
                          relation: target.relation)
    }
    
    func constrain(_ baseline: Baseline, to target: VerticalTarget?) -> NSLayoutConstraint? {
        guard let target = target else { return nil }
        return GetLaid.constrain(.init(view: self, baseline: baseline),
                          to: target.anchor,
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
    
    func constrain(to item: LayoutItem?) -> [NSLayoutConstraint?] {
        constrain(to: item?.all)
    }
    
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
    
    func constrain(to target: HorizontalTarget?) -> NSLayoutConstraint? {
        guard let target = target else { return nil }
        return constrain(target.anchor.position, to: target)
    }
    
    func constrain(to target: VerticalTarget?) -> NSLayoutConstraint? {
        guard let target = target else { return nil }
        return constrain(target.anchor.position, to: target)
    }
    
    // MARK: - Constrain Item Next to Other Item - Maximum Gap
    
    func constrain(toTheRightOf item: LayoutItem?, maxGap: CGFloat) -> [NSLayoutConstraint?] {
        [ constrain(toTheRightOf: item, minGap: 0),
          constrain(.left, to: item?.right(offset: maxGap).max) ]
    }
    
    func constrain(toTheLeftOf item: LayoutItem?, maxGap: CGFloat) -> [NSLayoutConstraint?] {
        [ constrain(toTheLeftOf: item, minGap: 0),
          constrain(.right, to: item?.left(offset: -maxGap).min) ]
    }
    
    func constrain(after item: LayoutItem?, maxGap: CGFloat) -> [NSLayoutConstraint?] {
        [ constrain(after: item, minGap: 0),
          constrain(.leading, to: item?.trailing(offset: maxGap).max) ]
    }
    
    func constrain(before item: LayoutItem?, maxGap: CGFloat) -> [NSLayoutConstraint?] {
        [ constrain(before: item, minGap: 0),
          constrain(.trailing, to: item?.leading(offset: -maxGap).min) ]
    }
    
    func constrain(above item: LayoutItem?, maxGap: CGFloat) -> [NSLayoutConstraint?] {
        [ constrain(above: item, minGap: 0),
          constrain(.bottom, to: item?.top(offset: -maxGap).min) ]
    }
    
    func constrain(below item: LayoutItem?, maxGap: CGFloat) -> [NSLayoutConstraint?] {
        [ constrain(below: item, minGap: 0),
          constrain(.top, to: item?.bottom(offset: maxGap).max) ]
    }
    
    // MARK: - Constrain Item Next to Other Item - Minimum Gap
    
    func constrain(toTheRightOf item: LayoutItem?, minGap: CGFloat) -> NSLayoutConstraint? {
        constrain(.left, to: item?.right(offset: minGap).min)
    }
    
    func constrain(toTheLeftOf item: LayoutItem?, minGap: CGFloat) -> NSLayoutConstraint? {
        constrain(.right, to: item?.left(offset: -minGap).max)
    }
    
    func constrain(after item: LayoutItem?, minGap: CGFloat) -> NSLayoutConstraint? {
        constrain(.leading, to: item?.trailing(offset: minGap).min)
    }
    
    func constrain(before item: LayoutItem?, minGap: CGFloat) -> NSLayoutConstraint? {
        constrain(.trailing, to: item?.leading(offset: -minGap).max)
    }
    
    func constrain(above item: LayoutItem?, minGap: CGFloat) -> NSLayoutConstraint? {
        constrain(.bottom, to: item?.top(offset: -minGap).max)
    }
    
    func constrain(below item: LayoutItem?, minGap: CGFloat) -> NSLayoutConstraint? {
        constrain(.top, to: item?.bottom(offset: minGap).min)
    }
    
    // MARK: - Constrain Item Next to Other Item - Exact Gap
    
    func constrain(toTheRightOf item: LayoutItem?, gap: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(.left, to: item?.right(offset: gap))
    }
    
    func constrain(toTheLeftOf item: LayoutItem?, gap: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(.right, to: item?.left(offset: -gap))
    }
    
    func constrain(after item: LayoutItem?, gap: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(.leading, to: item?.trailing(offset: gap))
    }
    
    func constrain(before item: LayoutItem?, gap: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(.trailing, to: item?.leading(offset: -gap))
    }
    
    func constrain(above item: LayoutItem?, gap: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(.bottom, to: item?.top(offset: -gap))
    }
    
    func constrain(below item: LayoutItem?, gap: CGFloat = 0) -> NSLayoutConstraint? {
        constrain(.top, to: item?.bottom(offset: gap))
    }
    
    // MARK: - Constrain Single Position to Target
    
    func constrain(_ position: VerticalPosition,
                   to target: BaselineTarget?) -> NSLayoutConstraint? {
        guard let target = target else { return nil }
        return GetLaid.constrain(.init(item: self, position: position),
                          to: target.anchor,
                          offset: target.offset,
                          relation: target.relation)
    }
    
    func constrain(_ position: VerticalPosition,
                   to target: VerticalTarget?) -> NSLayoutConstraint? {
        guard let target = target else { return nil }
        return GetLaid.constrain(.init(item: self, position: position),
                          to: target.anchor,
                          offset: target.offset,
                          relation: target.relation)
    }
    
    func constrain(_ position: HorizontalPosition,
                   to target: HorizontalTarget?) -> NSLayoutConstraint? {
        guard let target = target else { return nil }
        return GetLaid.constrain(.init(item: self, position: position),
                                 to: target.anchor,
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

public struct BaselineTarget: PositionTarget {
    let anchor: BaselineAnchor
    let offset: CGFloat
    public var relation = Relation.exact
}

public struct VerticalTarget: PositionTarget {
    let anchor: VerticalAnchor
    let offset: CGFloat
    public var relation = Relation.exact
}

public struct HorizontalTarget: PositionTarget {
    let anchor: HorizontalAnchor
    let offset: CGFloat
    public var relation = Relation.exact
}

public extension PositionTarget {
    var min: Self { with(.minimum) }
    var max: Self { with(.maximum) }
    func at(_ factor: CGFloat) -> Self { with(.relative(factor)) }
    func with(_ relation: Relation) -> Self {
        var copy = self
        copy.relation = relation
        return copy
    }
}

public protocol PositionTarget {
    var relation: Relation { get set }
}

public enum Relation {
    case exact
    case minimum
    case maximum
    case relative(CGFloat)
}

// MARK: - Internal API

struct GetLaid {
    static func constrain(_ anchor: VerticalAnchor,
                          to targetAnchor: VerticalAnchor,
                          offset: CGFloat,
                          relation: Relation) -> NSLayoutConstraint {
        switch relation {
        case .exact:
            return anchor.nsAnchor.constraint(equalTo: targetAnchor.nsAnchor,
                                              constant: offset).activate()
        case .minimum:
            return anchor.nsAnchor.constraint(greaterThanOrEqualTo: targetAnchor.nsAnchor,
                                              constant: offset).activate()
        case .maximum:
            return anchor.nsAnchor.constraint(lessThanOrEqualTo: targetAnchor.nsAnchor,
                                              constant: offset).activate()
        case .relative(let factor):
            return NSLayoutConstraint(item: anchor.item,
                                      attribute: anchor.position.attribute,
                                      relatedBy: .equal,
                                      toItem: targetAnchor.item,
                                      attribute: targetAnchor.position.attribute,
                                      multiplier: factor,
                                      constant: offset).activate()
        }
    }
    
    static func constrain(_ anchor: VerticalAnchor,
                          to targetAnchor: BaselineAnchor,
                          offset: CGFloat,
                          relation: Relation) -> NSLayoutConstraint {
        switch relation {
        case .exact:
            return anchor.nsAnchor.constraint(equalTo: targetAnchor.nsAnchor,
                                              constant: offset).activate()
        case .minimum:
            return anchor.nsAnchor.constraint(greaterThanOrEqualTo: targetAnchor.nsAnchor,
                                              constant: offset).activate()
        case .maximum:
            return anchor.nsAnchor.constraint(lessThanOrEqualTo: targetAnchor.nsAnchor,
                                              constant: offset).activate()
        case .relative(let factor):
            return NSLayoutConstraint(item: anchor.item,
                                      attribute: anchor.position.attribute,
                                      relatedBy: .equal,
                                      toItem: targetAnchor.view,
                                      attribute: targetAnchor.baseline.attribute,
                                      multiplier: factor,
                                      constant: offset).activate()
        }
    }
    
    static func constrain(_ anchor: BaselineAnchor,
                          to targetAnchor: VerticalAnchor,
                          offset: CGFloat,
                          relation: Relation) -> NSLayoutConstraint {
        switch relation {
        case .exact:
            return anchor.nsAnchor.constraint(equalTo: targetAnchor.nsAnchor,
                                              constant: offset).activate()
        case .minimum:
            return anchor.nsAnchor.constraint(greaterThanOrEqualTo: targetAnchor.nsAnchor,
                                              constant: offset).activate()
        case .maximum:
            return anchor.nsAnchor.constraint(lessThanOrEqualTo: targetAnchor.nsAnchor,
                                              constant: offset).activate()
        case .relative(let factor):
            return NSLayoutConstraint(item: anchor.view,
                                      attribute: anchor.baseline.attribute,
                                      relatedBy: .equal,
                                      toItem: targetAnchor.item,
                                      attribute: targetAnchor.position.attribute,
                                      multiplier: factor,
                                      constant: offset).activate()
        }
    }
    
    static func constrain(_ anchor: BaselineAnchor,
                          to targetAnchor: BaselineAnchor,
                          offset: CGFloat,
                          relation: Relation) -> NSLayoutConstraint {
        switch relation {
        case .exact:
            return anchor.nsAnchor.constraint(equalTo: targetAnchor.nsAnchor,
                                              constant: offset).activate()
        case .minimum:
            return anchor.nsAnchor.constraint(greaterThanOrEqualTo: targetAnchor.nsAnchor,
                                              constant: offset).activate()
        case .maximum:
            return anchor.nsAnchor.constraint(lessThanOrEqualTo: targetAnchor.nsAnchor,
                                              constant: offset).activate()
        case .relative(let factor):
            return NSLayoutConstraint(item: anchor.view,
                                      attribute: anchor.baseline.attribute,
                                      relatedBy: .equal,
                                      toItem: targetAnchor.view,
                                      attribute: targetAnchor.baseline.attribute,
                                      multiplier: factor,
                                      constant: offset).activate()
        }
    }
    
    static func constrain(_ anchor: HorizontalAnchor,
                          to targetAnchor: HorizontalAnchor,
                          offset: CGFloat,
                          relation: Relation) -> NSLayoutConstraint {
        switch relation {
        case .exact:
            return anchor.nsAnchor.constraint(equalTo: targetAnchor.nsAnchor,
                                              constant: offset).activate()
        case .minimum:
            return anchor.nsAnchor.constraint(greaterThanOrEqualTo: targetAnchor.nsAnchor,
                                              constant: offset).activate()
        case .maximum:
            return anchor.nsAnchor.constraint(lessThanOrEqualTo: targetAnchor.nsAnchor,
                                              constant: offset).activate()
        case .relative(let factor):
            return NSLayoutConstraint(item: anchor.item,
                                      attribute: anchor.position.attribute,
                                      relatedBy: .equal,
                                      toItem: targetAnchor.item,
                                      attribute: targetAnchor.position.attribute,
                                      multiplier: factor,
                                      constant: offset).activate()
        }
    }
}

struct HorizontalAnchor {
    var nsAnchor: NSLayoutXAxisAnchor { item.nsAnchor(for: position) }
    let item: LayoutItem
    let position: HorizontalPosition
}

struct VerticalAnchor {
    var nsAnchor: NSLayoutYAxisAnchor { item.nsAnchor(for: position) }
    let item: LayoutItem
    let position: VerticalPosition
}

struct BaselineAnchor {
    var nsAnchor: NSLayoutYAxisAnchor { view.nsAnchor(for: baseline) }
    let view: LayoutView
    let baseline: Baseline
}

extension LayoutView {
    func nsAnchor(for baseline: Baseline) -> NSLayoutYAxisAnchor {
        switch baseline {
        case .firstBaseline: return firstBaselineAnchor
        case .lastBaseline: return lastBaselineAnchor
        }
    }
}

extension LayoutItem {
    func nsAnchor(for position: VerticalPosition) -> NSLayoutYAxisAnchor {
        switch position {
        case .top: return topAnchor
        case .centerY: return centerYAnchor
        case .bottom: return bottomAnchor
        }
    }
    
    func nsAnchor(for position: HorizontalPosition) -> NSLayoutXAxisAnchor {
        switch position {
        case .leading: return leadingAnchor
        case .centerX: return centerXAnchor
        case .trailing: return trailingAnchor
        case .left: return leftAnchor
        case .right: return rightAnchor
        }
    }
}

public enum VerticalPosition {
    var attribute: LayoutAttribute {
        switch self {
        case .top: return .top
        case .centerY: return .centerY
        case .bottom: return .bottom
        }
    }
    
    case top, centerY, bottom
}

public enum HorizontalPosition {
    var attribute: LayoutAttribute {
        switch self {
        case .leading: return .leading
        case .centerX: return .centerX
        case .trailing: return .trailing
        case .left: return .left
        case .right: return .right
        }
    }
    
    case leading, centerX, trailing, left, right
}

public enum Baseline {
    var attribute: LayoutAttribute {
        switch self {
        case .firstBaseline: return .firstBaseline
        case .lastBaseline: return .lastBaseline
        }
    }
    
    case firstBaseline, lastBaseline
}
