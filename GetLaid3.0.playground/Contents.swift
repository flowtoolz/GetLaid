import UIKit
import PlaygroundSupport

// MARK: - Public API

extension LayoutView {
    
    // MARK: - Constrain View to Single Baseline Target
    
    func constrain(to target: BaselineTarget) {
        constrain(target.anchor.baseline, to: target)
    }
    
    // MARK: - Constrain Single Baseline to Target
    
    func constrain(_ baseline: Baseline, to target: BaselineTarget) {
        GetLaid.constrain(.init(view: self, baseline: baseline),
                          to: target.anchor,
                          offset: target.offset)
    }
    
    func constrain(_ baseline: Baseline, to target: VerticalTarget) {
        GetLaid.constrain(.init(view: self, baseline: baseline),
                          to: target.anchor,
                          offset: target.offset)
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
    
    func constrain(to item: LayoutItem) { constrain(to: item.all) }
    
    func constrain(to targetCombination: ItemPositionTargetCombination) {
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
    
    func constrain(to target: HorizontalTarget) {
        constrain(target.anchor.position, to: target)
    }
    
    func constrain(to target: VerticalTarget) {
        constrain(target.anchor.position, to: target)
    }
    
    // MARK: - Constrain Single Position to Target
    
    func constrain(_ position: VerticalPosition, to target: BaselineTarget) {
        GetLaid.constrain(.init(item: self, position: position),
                          to: target.anchor,
                          offset: target.offset)
    }
    
    func constrain(_ position: VerticalPosition, to target: VerticalTarget) {
        GetLaid.constrain(.init(item: self, position: position),
                          to: target.anchor,
                          offset: target.offset)
    }
    
    func constrain(_ position: HorizontalPosition, to target: HorizontalTarget) {
        let anchor = HorizontalAnchor(item: self, position: position)
        GetLaid.constrain(anchor, to: target.anchor, offset: target.offset)
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

// MARK: - Internal API

struct ItemPositionTargetCombination {
    let horizontalTargets: [HorizontalTarget]
    let verticalTargets: [VerticalTarget]
}

struct BaselineTarget {
    let anchor: BaselineAnchor
    let offset: CGFloat
}

struct VerticalTarget {
    let anchor: VerticalAnchor
    let offset: CGFloat
}

struct HorizontalTarget {
    let anchor: HorizontalAnchor
    let offset: CGFloat
}

struct GetLaid {
    static func constrain(_ sourceVerticalAnchor: VerticalAnchor,
                          to targetVerticalAnchor: VerticalAnchor,
                          offset: CGFloat = 0) {
        let sourceAnchor = sourceVerticalAnchor.item.anchor(for: sourceVerticalAnchor.position)
        let targetAnchor = targetVerticalAnchor.item.anchor(for: targetVerticalAnchor.position)
        sourceAnchor.constraint(equalTo: targetAnchor, constant: offset).isActive = true
    }
    
    static func constrain(_ sourceVerticalAnchor: VerticalAnchor,
                          to targetBaselineAnchor: BaselineAnchor,
                          offset: CGFloat = 0) {
        let sourceAnchor = sourceVerticalAnchor.item.anchor(for: sourceVerticalAnchor.position)
        let targetAnchor = targetBaselineAnchor.view.anchor(for: targetBaselineAnchor.baseline)
        sourceAnchor.constraint(equalTo: targetAnchor, constant: offset).isActive = true
    }
    
    static func constrain(_ sourceBaselineAnchor: BaselineAnchor,
                          to targetVerticalAnchor: VerticalAnchor,
                          offset: CGFloat = 0) {
        let sourceAnchor = sourceBaselineAnchor.view.anchor(for: sourceBaselineAnchor.baseline)
        let targetAnchor = targetVerticalAnchor.item.anchor(for: targetVerticalAnchor.position)
        
        sourceAnchor.constraint(equalTo: targetAnchor, constant: offset).isActive = true
    }
    
    static func constrain(_ sourceBaselineAnchor: BaselineAnchor,
                          to targetBaselineAnchor: BaselineAnchor,
                          offset: CGFloat = 0) {
        let sourceAnchor = sourceBaselineAnchor.view.anchor(for: sourceBaselineAnchor.baseline)
        let targetAnchor = targetBaselineAnchor.view.anchor(for: targetBaselineAnchor.baseline)
        
        sourceAnchor.constraint(equalTo: targetAnchor, constant: offset).isActive = true
    }
    
    static func constrain(_ sourceHorizontalAnchor: HorizontalAnchor,
                          to targetHorizontalAnchor: HorizontalAnchor,
                          offset: CGFloat = 0) {
        let sourceAnchor = sourceHorizontalAnchor.item.anchor(for: sourceHorizontalAnchor.position)
        let targetAnchor = targetHorizontalAnchor.item.anchor(for: targetHorizontalAnchor.position)
        sourceAnchor.constraint(equalTo: targetAnchor, constant: offset).isActive = true
    }
}

struct HorizontalAnchor {
    let item: LayoutItem
    let position: HorizontalPosition
}

struct VerticalAnchor {
    let item: LayoutItem
    let position: VerticalPosition
}

struct BaselineAnchor {
    let view: LayoutView
    let baseline: Baseline
}

extension LayoutView {
    func anchor(for baseline: Baseline) -> NSLayoutYAxisAnchor {
        switch baseline {
        case .firstBaseline: return firstBaselineAnchor
        case .lastBaseline: return lastBaselineAnchor
        }
    }
}

extension LayoutItem {
    func anchor(for position: VerticalPosition) -> NSLayoutYAxisAnchor {
        switch position {
        case .top: return topAnchor
        case .centerY: return centerYAnchor
        case .bottom: return bottomAnchor
        }
    }
    
    func anchor(for position: HorizontalPosition) -> NSLayoutXAxisAnchor {
        switch position {
        case .leading: return leadingAnchor
        case .centerX: return centerXAnchor
        case .trailing: return trailingAnchor
        case .left: return leftAnchor
        case .right: return rightAnchor
        }
    }
}

extension UIView: LayoutView {}
protocol LayoutView: LayoutItem {
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
    case top, centerY, bottom
}

enum HorizontalPosition {
    case leading, centerX, trailing, left, right
}

enum Baseline {
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
        label.constrain(to: top)
        label.constrain(to: left)
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

PlaygroundPage.current.liveView = MyViewController()
