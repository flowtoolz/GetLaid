#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    @discardableResult
    func constrain(to item: LayoutItem?) -> [NSLayoutConstraint?]
    {
        constrain(to: item?.all)
    }
    
    @discardableResult
    func constrain(to targets: ItemPositionTargetCombination?) -> [NSLayoutConstraint?]
    {
        guard let targets = targets else { return [] }
        var constraints = [NSLayoutConstraint]()
        
        for verticalTarget in targets.verticalTargets
        {
            let sourceAnchor = anchor(for: verticalTarget.anchor.position)
            if let constraint = sourceAnchor.constrain(to: verticalTarget)
            {
                constraints.append(constraint)
            }
        }
        
        for horizontalTarget in targets.horizontalTargets
        {
            let sourceAnchor = anchor(for: horizontalTarget.anchor.position)
            if let constraint = sourceAnchor.constrain(to: horizontalTarget)
            {
                constraints.append(constraint)
            }
        }
        
        return constraints
    }
    
    var center: ItemPositionTargetCombination { center() }
    
    func center(xOffset: CGFloat = 0, yOffset: CGFloat = 0) -> ItemPositionTargetCombination
    {
        .init(horizontalTargets: [ .init(anchor: .init(item: self, position: .centerX),
                                         offset: xOffset) ],
              verticalTargets: [ .init(anchor: .init(item: self, position: .centerY),
                                       offset: yOffset) ])
    }
    
    var all: ItemPositionTargetCombination { all() }
    
    func all(topOffset: CGFloat = 0,
             leadingOffset: CGFloat = 0,
             bottomOffset: CGFloat = 0,
             trailingOffset: CGFloat = 0) -> ItemPositionTargetCombination
    {
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
             rightOffset: CGFloat) -> ItemPositionTargetCombination
    {
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
                   trailingOffset: CGFloat = 0) -> ItemPositionTargetCombination
    {
        .init(horizontalTargets: [ .init(anchor: .init(item: self, position: .leading),
                                         offset: leadingOffset),
                                   .init(anchor: .init(item: self, position: .trailing),
                                         offset: trailingOffset) ],
              verticalTargets: [ .init(anchor: .init(item: self, position: .bottom),
                                       offset: bottomOffset) ])
    }
    
    func allButTop(leftOffset: CGFloat,
                   bottomOffset: CGFloat = 0,
                   rightOffset: CGFloat) -> ItemPositionTargetCombination
    {
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
                       trailingOffset: CGFloat = 0) -> ItemPositionTargetCombination
    {
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
                      trailingOffset: CGFloat = 0) -> ItemPositionTargetCombination
    {
        .init(horizontalTargets: [ .init(anchor: .init(item: self, position: .leading),
                                         offset: leadingOffset),
                                   .init(anchor: .init(item: self, position: .trailing),
                                         offset: trailingOffset) ],
              verticalTargets: [ .init(anchor: .init(item: self, position: .top),
                                       offset: topOffset) ])
    }
    
    func allButBottom(topOffset: CGFloat = 0,
                      leftOffset: CGFloat,
                      rightOffset: CGFloat) -> ItemPositionTargetCombination
    {
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
                        bottomOffset: CGFloat = 0) -> ItemPositionTargetCombination
    {
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
                    rightOffset: CGFloat = 0) -> ItemPositionTargetCombination
    {
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
                     bottomOffset: CGFloat = 0) -> ItemPositionTargetCombination
    {
        .init(horizontalTargets: [ .init(anchor: .init(item: self, position: .left),
                                         offset: leftOffset) ],
              verticalTargets: [ .init(anchor: .init(item: self, position: .top),
                                       offset: topOffset),
                                 .init(anchor: .init(item: self, position: .bottom),
                                       offset: bottomOffset) ])
    }
}

public struct ItemPositionTargetCombination
{
    let horizontalTargets: [HorizontalTarget]
    let verticalTargets: [VerticalTarget]
}
