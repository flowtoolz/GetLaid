import UIKit
import PlaygroundSupport

// MARK: - Public API

extension LayoutView {
    func constrain(_ baseline: Baseline, to target: VerticalViewTarget) {
        GetLaid.constrain(.baselineAnchor(.init(view: self, baseline: baseline)),
                          to: target.anchor,
                          offset: target.offset)
    }
    
    var firstBaseline: VerticalViewAnchor {
        .baselineAnchor(.init(view: self, baseline: .firstBaseline))
    }
    
    var lastBaseline: VerticalViewAnchor {
        .baselineAnchor(.init(view: self, baseline: .lastBaseline))
    }
}

extension LayoutItem {
    
    // MARK: - Constrain Item to Multiple Targets
    
    func constrain(to targetCombination: ItemPositionTargetCombination) {
        for verticalTarget in targetCombination.vericalTargets {
            let position = verticalTarget.anchor.position
            GetLaid.constrain(.itemAnchor(.init(item: self,
                                                        position: position)),
                              to: .itemAnchor(verticalTarget.anchor),
                              offset: verticalTarget.offset)
        }
        for horizontalTarget in targetCombination.horizonalTargets {
            constrain(horizontalTarget.anchor.position, to: horizontalTarget)
        }
    }
    
    var center: ItemPositionTargetCombination { center() }
    func center(xOffset: CGFloat = 0, yOffset: CGFloat = 0) -> ItemPositionTargetCombination {
        .init(horizonalTargets: [ .init(anchor: .init(item: self, position: .centerX),
                                        offset: xOffset) ],
              vericalTargets: [ .init(anchor: .init(item: self, position: .centerY),
                                      offset: yOffset) ])
    }
    
    var allButTop: ItemPositionTargetCombination { allButTop() }
    func allButTop(leadingOffset: CGFloat = 0,
                   bottomOffset: CGFloat = 0,
                   trailingOffset: CGFloat = 0) -> ItemPositionTargetCombination {
        .init(horizonalTargets: [ .init(anchor: .init(item: self, position: .leading),
                                        offset: leadingOffset),
                                  .init(anchor: .init(item: self, position: .trailing),
                                        offset: trailingOffset) ],
              vericalTargets: [ .init(anchor: .init(item: self, position: .bottom),
                                      offset: bottomOffset) ])
    }
    
    var allButLeading: ItemPositionTargetCombination { allButLeading() }
    func allButLeading(topOffset: CGFloat = 0,
                       bottomOffset: CGFloat = 0,
                       trailingOffset: CGFloat = 0) -> ItemPositionTargetCombination {
        .init(horizonalTargets: [ .init(anchor: .init(item: self, position: .trailing),
                                        offset: trailingOffset) ],
              vericalTargets: [ .init(anchor: .init(item: self, position: .top),
                                      offset: topOffset),
                                .init(anchor: .init(item: self, position: .bottom),
                                      offset: bottomOffset) ])
    }
    
    var allButBottom: ItemPositionTargetCombination { allButBottom() }
    func allButBottom(topOffset: CGFloat = 0,
                      leadingOffset: CGFloat = 0,
                      trailingOffset: CGFloat = 0) -> ItemPositionTargetCombination {
        .init(horizonalTargets: [ .init(anchor: .init(item: self, position: .leading),
                                        offset: leadingOffset),
                                  .init(anchor: .init(item: self, position: .trailing),
                                        offset: trailingOffset) ],
              vericalTargets: [ .init(anchor: .init(item: self, position: .top),
                                      offset: topOffset) ])
    }
    
    var allButTrailing: ItemPositionTargetCombination { allButTrailing() }
    func allButTrailing(topOffset: CGFloat = 0,
                        leadingOffset: CGFloat = 0,
                        bottomOffset: CGFloat = 0) -> ItemPositionTargetCombination {
        .init(horizonalTargets: [ .init(anchor: .init(item: self, position: .leading),
                                        offset: leadingOffset) ],
              vericalTargets: [ .init(anchor: .init(item: self, position: .top),
                                      offset: topOffset),
                                .init(anchor: .init(item: self, position: .bottom),
                                      offset: bottomOffset) ])
    }
    
    var allButLeft: ItemPositionTargetCombination { allButLeft() }
    func allButLeft(topOffset: CGFloat = 0,
                    bottomOffset: CGFloat = 0,
                    rightOffset: CGFloat = 0) -> ItemPositionTargetCombination {
        .init(horizonalTargets: [ .init(anchor: .init(item: self, position: .right),
                                        offset: rightOffset) ],
              vericalTargets: [ .init(anchor: .init(item: self, position: .top),
                                      offset: topOffset),
                                .init(anchor: .init(item: self, position: .bottom),
                                      offset: bottomOffset) ])
    }
    
    var allButRight: ItemPositionTargetCombination { allButRight() }
    func allButRight(topOffset: CGFloat = 0,
                     leftOffset: CGFloat = 0,
                     bottomOffset: CGFloat = 0) -> ItemPositionTargetCombination {
        .init(horizonalTargets: [ .init(anchor: .init(item: self, position: .left),
                                        offset: leftOffset) ],
              vericalTargets: [ .init(anchor: .init(item: self, position: .top),
                                      offset: topOffset),
                                .init(anchor: .init(item: self, position: .bottom),
                                      offset: bottomOffset) ])
    }
    
    // MARK: - Constrain Single Position to Target
    
    func constrain(_ position: VerticalPosition, to target: VerticalViewTarget) {
        GetLaid.constrain(.itemAnchor(.init(item: self, position: position)),
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
    
    var top: VerticalViewTarget { top(offset: 0) }
    func top(offset: CGFloat) -> VerticalViewTarget {
        .init(anchor: .itemAnchor(.init(item: self, position: .top)),
              offset: offset)
    }
    
    var bottom: VerticalViewTarget { bottom(offset: 0) }
    func bottom(offset: CGFloat) -> VerticalViewTarget {
        .init(anchor: .itemAnchor(.init(item: self, position: .bottom)),
              offset: offset)
    }
}

// MARK: - Internal API

struct ItemPositionTargetCombination {
    let horizonalTargets: [HorizontalTarget]
    let vericalTargets: [VerticalItemTarget]
}

struct VerticalViewTarget {
    let anchor: VerticalViewAnchor
    let offset: CGFloat
}

struct VerticalItemTarget {
    let anchor: VerticalItemAnchor
    let offset: CGFloat
}

struct HorizontalTarget {
    let anchor: HorizontalAnchor
    let offset: CGFloat
}

struct GetLaid {
    static func constrain(_ sourceVerticalAnchor: VerticalViewAnchor,
                          to targetVerticalAnchor: VerticalViewAnchor,
                          offset: CGFloat = 0) {
        let sourceAnchor = sourceVerticalAnchor.anchor
        let targetAnchor = targetVerticalAnchor.anchor
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

enum VerticalViewAnchor {
    var anchor: NSLayoutYAxisAnchor {
        switch self {
        case .itemAnchor(let itemAnchor):
            return itemAnchor.item.anchor(for: itemAnchor.position)
        case .baselineAnchor(let baselineAnchor):
            return baselineAnchor.view.anchor(for: baselineAnchor.baseline)
        }
    }
    case itemAnchor(VerticalItemAnchor)
    case baselineAnchor(BaselineAnchor)
}

struct VerticalItemAnchor {
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
        label.constrain(to: center)
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

PlaygroundPage.current.liveView = MyViewController()
