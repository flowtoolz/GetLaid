import UIKit
import PlaygroundSupport

// MARK: - Public API

extension LayoutView {
    func constrain(to targetCombination: ViewPositionTargetCombination) {
        for verticalTarget in targetCombination.vericalTargets {
            switch verticalTarget.anchor {
            case .itemAnchor(let itemAnchor):
                constrain(itemAnchor.position, to: verticalTarget)
            case .baselineAnchor(let baselineAnchor):
                constrain(baselineAnchor.baseline, to: verticalTarget)
            }
        }
        for horizontalTarget in targetCombination.horizonalTargets {
            constrain(horizontalTarget.anchor.position, to: horizontalTarget)
        }
    }
    
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

struct ViewPositionTargetCombination {
    let horizonalTargets: [HorizontalTarget]
    let vericalTargets: [VerticalViewTarget]
}

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
        case .bottom: return bottomAnchor
        }
    }
    
    func anchor(for position: HorizontalPosition) -> NSLayoutXAxisAnchor {
        switch position {
        case .leading: return leadingAnchor
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
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
}

enum VerticalPosition {
    case top, bottom
}

enum HorizontalPosition {
    case leading, trailing, left, right
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
        label.constrain(.top, to: self.top(offset: 12))
        label.constrain(.left, to: self.left)
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

PlaygroundPage.current.liveView = MyViewController()
