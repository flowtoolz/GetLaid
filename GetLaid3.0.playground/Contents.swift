import UIKit
import PlaygroundSupport

// MARK: - Public API

extension LayoutView {
    
    // MARK: - Constrain View to Single Baseline Target
    
    func constrain(to target: BaselineTarget?) {
        guard let target = target else { return }
        constrain(target.anchor.baseline, to: target)
    }
    
    // MARK: - Constrain Single Baseline to Target
    
    func constrain(_ baseline: Baseline, to target: BaselineTarget?) {
        guard let target = target else { return }
        GetLaid.constrain(.init(view: self, baseline: baseline),
                          to: target.anchor,
                          offset: target.offset,
                          relation: target.relation)
    }
    
    func constrain(_ baseline: Baseline, to target: VerticalTarget?) {
        guard let target = target else { return }
        GetLaid.constrain(.init(view: self, baseline: baseline),
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

extension LayoutItem {
    
    // MARK: - Constrain Item to Multiple Targets
    
    func constrain(to item: LayoutItem?) { constrain(to: item?.all) }
    
    func constrain(to targetCombination: ItemPositionTargetCombination?) {
        guard let targetCombination = targetCombination else { return }
        for verticalTarget in targetCombination.verticalTargets {
            constrain(verticalTarget.anchor.position, to: verticalTarget)
        }
        for horizontalTarget in targetCombination.horizontalTargets {
            constrain(horizontalTarget.anchor.position, to: horizontalTarget)
        }
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
    
    func constrain(to target: HorizontalTarget?) {
        guard let target = target else { return }
        constrain(target.anchor.position, to: target)
    }
    
    func constrain(to target: VerticalTarget?) {
        guard let target = target else { return }
        constrain(target.anchor.position, to: target)
    }
    
    // MARK: - Constrain Item Next to Other Item - Maximum Gap
    
    func constrain(toTheRightOf item: LayoutItem?, maxGap: CGFloat) {
        constrain(toTheRightOf: item, minGap: 0)
        constrain(.left, to: item?.right(offset: maxGap).max)
    }
    
    func constrain(toTheLeftOf item: LayoutItem?, maxGap: CGFloat) {
        constrain(toTheLeftOf: item, minGap: 0)
        constrain(.right, to: item?.left(offset: -maxGap).min)
    }
    
    func constrain(after item: LayoutItem?, maxGap: CGFloat) {
        constrain(after: item, minGap: 0)
        constrain(.leading, to: item?.trailing(offset: maxGap).max)
    }
    
    func constrain(before item: LayoutItem?, maxGap: CGFloat) {
        constrain(before: item, minGap: 0)
        constrain(.trailing, to: item?.leading(offset: -maxGap).min)
    }
    
    func constrain(above item: LayoutItem?, maxGap: CGFloat) {
        constrain(above: item, minGap: 0)
        constrain(.bottom, to: item?.top(offset: -maxGap).min)
    }
    
    func constrain(below item: LayoutItem?, maxGap: CGFloat) {
        constrain(below: item, minGap: 0)
        constrain(.top, to: item?.bottom(offset: maxGap).max)
    }
    
    // MARK: - Constrain Item Next to Other Item - Minimum Gap
    
    func constrain(toTheRightOf item: LayoutItem?, minGap: CGFloat) {
        constrain(.left, to: item?.right(offset: minGap).min)
    }
    
    func constrain(toTheLeftOf item: LayoutItem?, minGap: CGFloat) {
        constrain(.right, to: item?.left(offset: -minGap).max)
    }
    
    func constrain(after item: LayoutItem?, minGap: CGFloat) {
        constrain(.leading, to: item?.trailing(offset: minGap).min)
    }
    
    func constrain(before item: LayoutItem?, minGap: CGFloat) {
        constrain(.trailing, to: item?.leading(offset: -minGap).max)
    }
    
    func constrain(above item: LayoutItem?, minGap: CGFloat) {
        constrain(.bottom, to: item?.top(offset: -minGap).max)
    }
    
    func constrain(below item: LayoutItem?, minGap: CGFloat) {
        constrain(.top, to: item?.bottom(offset: minGap).min)
    }
    
    // MARK: - Constrain Item Next to Other Item - Exact Gap
    
    func constrain(toTheRightOf item: LayoutItem?, gap: CGFloat = 0) {
        constrain(.left, to: item?.right(offset: gap))
    }
    
    func constrain(toTheLeftOf item: LayoutItem?, gap: CGFloat = 0) {
        constrain(.right, to: item?.left(offset: -gap))
    }
    
    func constrain(after item: LayoutItem?, gap: CGFloat = 0) {
        constrain(.leading, to: item?.trailing(offset: gap))
    }
    
    func constrain(before item: LayoutItem?, gap: CGFloat = 0) {
        constrain(.trailing, to: item?.leading(offset: -gap))
    }
    
    func constrain(above item: LayoutItem?, gap: CGFloat = 0) {
        constrain(.bottom, to: item?.top(offset: -gap))
    }
    
    func constrain(below item: LayoutItem?, gap: CGFloat = 0) {
        constrain(.top, to: item?.bottom(offset: gap))
    }
    
    // MARK: - Constrain Single Position to Target
    
    func constrain(_ position: VerticalPosition, to target: BaselineTarget?) {
        guard let target = target else { return }
        GetLaid.constrain(.init(item: self, position: position),
                          to: target.anchor,
                          offset: target.offset,
                          relation: target.relation)
    }
    
    func constrain(_ position: VerticalPosition, to target: VerticalTarget?) {
        guard let target = target else { return }
        GetLaid.constrain(.init(item: self, position: position),
                          to: target.anchor,
                          offset: target.offset,
                          relation: target.relation)
    }
    
    func constrain(_ position: HorizontalPosition, to target: HorizontalTarget?) {
        guard let target = target else { return }
        GetLaid.constrain(.init(item: self, position: position),
                          to: target.anchor,
                          offset: target.offset,
                          relation: target.relation)
    }
    
    var leading: HorizontalTarget { leading(offset: 0) }
    func leading(offset: CGFloat) -> HorizontalTarget {
        .init(anchor: .init(item: self, position: .leading),
              offset: offset)
    }
    
    var trailing: HorizontalTarget { trailing(offset: 0) }
    func trailing(offset: CGFloat) -> HorizontalTarget {
        .init(anchor: .init(item: self, position: .trailing),
              offset: offset)
    }
    
    var left: HorizontalTarget { left(offset: 0) }
    func left(offset: CGFloat) -> HorizontalTarget {
        .init(anchor: .init(item: self, position: .left),
              offset: offset)
    }
    
    var right: HorizontalTarget { right(offset: 0) }
    func right(offset: CGFloat) -> HorizontalTarget {
        .init(anchor: .init(item: self, position: .right),
              offset: offset)
    }
    
    var top: VerticalTarget { top(offset: 0) }
    func top(offset: CGFloat) -> VerticalTarget {
        .init(anchor: .init(item: self, position: .top), offset: offset)
    }
    
    var bottom: VerticalTarget { bottom(offset: 0) }
    func bottom(offset: CGFloat) -> VerticalTarget {
        .init(anchor: .init(item: self, position: .bottom), offset: offset)
    }
}

struct ItemPositionTargetCombination {
    let horizontalTargets: [HorizontalTarget]
    let verticalTargets: [VerticalTarget]
}

struct BaselineTarget: PositionTarget {
    let anchor: BaselineAnchor
    let offset: CGFloat
    var relation = Relation.exact
}

struct VerticalTarget: PositionTarget {
    let anchor: VerticalAnchor
    let offset: CGFloat
    var relation = Relation.exact
}

struct HorizontalTarget: PositionTarget {
    let anchor: HorizontalAnchor
    let offset: CGFloat
    var relation = Relation.exact
}

extension PositionTarget {
    var min: Self { with(.minimum) }
    var max: Self { with(.maximum) }
    func at(_ factor: CGFloat) -> Self { with(.relative(factor)) }
    func with(_ relation: Relation) -> Self {
        var copy = self
        copy.relation = relation
        return copy
    }
}

protocol PositionTarget {
    var relation: Relation { get set }
}

enum Relation {
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
                          relation: Relation) {
        switch relation {
        case .exact:
            anchor.nsAnchor.constraint(equalTo: targetAnchor.nsAnchor,
                                       constant: offset).isActive = true
        case .minimum:
            anchor.nsAnchor.constraint(greaterThanOrEqualTo: targetAnchor.nsAnchor,
                                       constant: offset).isActive = true
        case .maximum:
            anchor.nsAnchor.constraint(lessThanOrEqualTo: targetAnchor.nsAnchor,
                                       constant: offset).isActive = true
        case .relative(let factor):
            NSLayoutConstraint(item: anchor.item,
                               attribute: anchor.position.attribute,
                               relatedBy: .equal,
                               toItem: targetAnchor.item,
                               attribute: targetAnchor.position.attribute,
                               multiplier: factor,
                               constant: offset).isActive = true
        }
    }
    
    static func constrain(_ anchor: VerticalAnchor,
                          to targetAnchor: BaselineAnchor,
                          offset: CGFloat,
                          relation: Relation) {
        switch relation {
        case .exact:
            anchor.nsAnchor.constraint(equalTo: targetAnchor.nsAnchor,
                                       constant: offset).isActive = true
        case .minimum:
            anchor.nsAnchor.constraint(greaterThanOrEqualTo: targetAnchor.nsAnchor,
                                       constant: offset).isActive = true
        case .maximum:
            anchor.nsAnchor.constraint(lessThanOrEqualTo: targetAnchor.nsAnchor,
                                       constant: offset).isActive = true
        case .relative(let factor):
            NSLayoutConstraint(item: anchor.item,
                               attribute: anchor.position.attribute,
                               relatedBy: .equal,
                               toItem: targetAnchor.view,
                               attribute: targetAnchor.baseline.attribute,
                               multiplier: factor,
                               constant: offset).isActive = true
        }
    }
    
    static func constrain(_ anchor: BaselineAnchor,
                          to targetAnchor: VerticalAnchor,
                          offset: CGFloat,
                          relation: Relation) {
        switch relation {
        case .exact:
            anchor.nsAnchor.constraint(equalTo: targetAnchor.nsAnchor,
                                       constant: offset).isActive = true
        case .minimum:
            anchor.nsAnchor.constraint(greaterThanOrEqualTo: targetAnchor.nsAnchor,
                                       constant: offset).isActive = true
        case .maximum:
            anchor.nsAnchor.constraint(lessThanOrEqualTo: targetAnchor.nsAnchor,
                                       constant: offset).isActive = true
        case .relative(let factor):
            NSLayoutConstraint(item: anchor.view,
                               attribute: anchor.baseline.attribute,
                               relatedBy: .equal,
                               toItem: targetAnchor.item,
                               attribute: targetAnchor.position.attribute,
                               multiplier: factor,
                               constant: offset).isActive = true
        }
    }
    
    static func constrain(_ anchor: BaselineAnchor,
                          to targetAnchor: BaselineAnchor,
                          offset: CGFloat,
                          relation: Relation) {
        switch relation {
        case .exact:
            anchor.nsAnchor.constraint(equalTo: targetAnchor.nsAnchor,
                                       constant: offset).isActive = true
        case .minimum:
            anchor.nsAnchor.constraint(greaterThanOrEqualTo: targetAnchor.nsAnchor,
                                       constant: offset).isActive = true
        case .maximum:
            anchor.nsAnchor.constraint(lessThanOrEqualTo: targetAnchor.nsAnchor,
                                       constant: offset).isActive = true
        case .relative(let factor):
            NSLayoutConstraint(item: anchor.view,
                               attribute: anchor.baseline.attribute,
                               relatedBy: .equal,
                               toItem: targetAnchor.view,
                               attribute: targetAnchor.baseline.attribute,
                               multiplier: factor,
                               constant: offset).isActive = true
        }
    }
    
    static func constrain(_ anchor: HorizontalAnchor,
                          to targetAnchor: HorizontalAnchor,
                          offset: CGFloat,
                          relation: Relation) {
        switch relation {
        case .exact:
            anchor.nsAnchor.constraint(equalTo: targetAnchor.nsAnchor,
                                       constant: offset).isActive = true
        case .minimum:
            anchor.nsAnchor.constraint(greaterThanOrEqualTo: targetAnchor.nsAnchor,
                                       constant: offset).isActive = true
        case .maximum:
            anchor.nsAnchor.constraint(lessThanOrEqualTo: targetAnchor.nsAnchor,
                                       constant: offset).isActive = true
        case .relative(let factor):
            NSLayoutConstraint(item: anchor.item,
                               attribute: anchor.position.attribute,
                               relatedBy: .equal,
                               toItem: targetAnchor.item,
                               attribute: targetAnchor.position.attribute,
                               multiplier: factor,
                               constant: offset).isActive = true
        }
    }
}

typealias LayoutAttribute = NSLayoutConstraint.Attribute

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

extension UIView: LayoutView {
    var parent: LayoutView? { superview }
}

protocol LayoutView: LayoutItem {
    var parent: LayoutView? { get }
    var firstBaselineAnchor: NSLayoutYAxisAnchor { get }
    var lastBaselineAnchor: NSLayoutYAxisAnchor { get }
}

extension UILayoutGuide: LayoutItem {}
protocol LayoutItem {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
}

enum VerticalPosition {
    var attribute: LayoutAttribute {
        switch self {
        case .top: return .top
        case .centerY: return .centerY
        case .bottom: return .bottom
        }
    }
    
    case top, centerY, bottom
}

enum HorizontalPosition {
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

enum Baseline {
    var attribute: LayoutAttribute {
        switch self {
        case .firstBaseline: return .firstBaseline
        case .lastBaseline: return .lastBaseline
        }
    }
    
    case firstBaseline, lastBaseline
}

// MARK: -

class MyViewController : UIViewController {
    override func loadView() { view = MyTestView() }
}

class MyTestView: UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .green
        let label = UILabel()
        label.text = "Hello AutoLayout!"
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.constrain(to: label.parent?.allButBottom)
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

PlaygroundPage.current.liveView = MyViewController()
