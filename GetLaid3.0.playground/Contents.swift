import UIKit
import PlaygroundSupport

// MARK: - Public API

extension LayoutView {
    func constrain(_ baseline: Baseline, to target: VerticalTarget) {
        GetLaid.constrain(.baseline(.init(layoutView: self, baseline: baseline)),
                          to: target.anchor,
                          offset: target.offset)
    }
    var firstBaseline: VerticalAnchor {
        .baseline(.init(layoutView: self, baseline: .firstBaseline))
    }
    var lastBaseline: VerticalAnchor {
        .baseline(.init(layoutView: self, baseline: .lastBaseline))
    }
}

extension LayoutItem {
    func constrain(_ position: VerticalPosition, to target: VerticalTarget) {
        GetLaid.constrain(.verticalPosition(.init(layoutItem: self, position: position)),
                          to: target.anchor,
                          offset: target.offset)
    }
    func constrain(_ position: HorizontalPosition, to target: HorizontalTarget) {
        let anchor = HorizontalAnchor(layoutItem: self, position: position)
        GetLaid.constrain(anchor, to: target.anchor, offset: target.offset)
    }
    
    var leading: HorizontalTarget { leading(offset: 0) }
    func leading(offset: CGFloat) -> HorizontalTarget {
        .init(anchor: .init(layoutItem: self, position: .leading),
              offset: offset)
    }
    
    var trailing: HorizontalTarget { trailing(offset: 0) }
    func trailing(offset: CGFloat) -> HorizontalTarget {
        .init(anchor: .init(layoutItem: self, position: .trailing),
              offset: offset)
    }
    
    var left: HorizontalTarget { left(offset: 0) }
    func left(offset: CGFloat) -> HorizontalTarget {
        .init(anchor: .init(layoutItem: self, position: .left),
              offset: offset)
    }
    
    var right: HorizontalTarget { right(offset: 0) }
    func right(offset: CGFloat) -> HorizontalTarget {
        .init(anchor: .init(layoutItem: self, position: .right),
              offset: offset)
    }
    
    var top: VerticalTarget { top(offset: 0) }
    func top(offset: CGFloat) -> VerticalTarget {
        .init(anchor: .verticalPosition(.init(layoutItem: self, position: .top)),
              offset: offset)
    }
    
    var bottom: VerticalTarget { bottom(offset: 0) }
    func bottom(offset: CGFloat) -> VerticalTarget {
        .init(anchor: .verticalPosition(.init(layoutItem: self, position: .bottom)),
              offset: offset)
    }
}

// MARK: - Internal API

struct GetLaid {
    static func constrain(_ sourceVerticalAnchor: VerticalAnchor,
                          to targetVerticalAnchor: VerticalAnchor,
                          offset: CGFloat = 0) {
        let sourceAnchor = sourceVerticalAnchor.anchor
        let targetAnchor = targetVerticalAnchor.anchor
        sourceAnchor.constraint(equalTo: targetAnchor, constant: offset).isActive = true
    }

    static func constrain(_ sourceHorizontalAnchor: HorizontalAnchor,
                          to targetHorizontalAnchor: HorizontalAnchor,
                          offset: CGFloat = 0) {
        let sourceAnchor = sourceHorizontalAnchor.layoutItem.anchor(for: sourceHorizontalAnchor.position)
        let targetAnchor = targetHorizontalAnchor.layoutItem.anchor(for: targetHorizontalAnchor.position)
        sourceAnchor.constraint(equalTo: targetAnchor, constant: offset).isActive = true
    }
}

struct HorizontalTarget {
    let anchor: HorizontalAnchor
    let offset: CGFloat
}

struct VerticalTarget {
    let anchor: VerticalAnchor
    let offset: CGFloat
}

struct HorizontalAnchor {
    let layoutItem: LayoutItem
    let position: HorizontalPosition
}

enum VerticalAnchor {
    var anchor: NSLayoutYAxisAnchor {
        switch self {
        case .verticalPosition(let verticalPositionAnchor):
            return verticalPositionAnchor.layoutItem.anchor(for: verticalPositionAnchor.position)
        case .baseline(let baselineAnchor):
            return baselineAnchor.layoutView.anchor(for: baselineAnchor.baseline)
        }
    }
    case verticalPosition(VerticalPositionAnchor)
    case baseline(BaselineAnchor)
}

struct VerticalPositionAnchor {
    let layoutItem: LayoutItem
    let position: VerticalPosition
}

struct BaselineAnchor {
    let layoutView: LayoutView
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
    func anchor(for verticalPosition: VerticalPosition) -> NSLayoutYAxisAnchor {
        switch verticalPosition {
        case .top: return topAnchor
        case .bottom: return bottomAnchor
        }
    }
    
    func anchor(for horizontalPosition: HorizontalPosition) -> NSLayoutXAxisAnchor {
        switch horizontalPosition {
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
        label.constrain(.top, to: self.top)
        label.constrain(.left, to: self.left)
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

PlaygroundPage.current.liveView = MyViewController()
