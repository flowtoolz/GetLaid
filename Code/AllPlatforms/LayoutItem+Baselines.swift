#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutItem
{
    // MARK: - Constrain Y Position to Baseline
    
    @discardableResult
    public func constrain(_ yPosition: YPosition,
                          to targetBaseline: BaselinePosition,
                          of target: LayoutView,
                          offset: CGFloat = 0) -> NSLayoutConstraint
    {
        let myAnchor = anchor(for: yPosition)
        let targetAnchor = target.anchor(for: targetBaseline)
        
        let constraint = myAnchor.constraint(equalTo: targetAnchor,
                                             constant: offset)
        
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    public func constrain(_ yPosition: YPosition,
                          to targetBaseline: BaselinePosition,
                          of target: LayoutView,
                          minimumOffset: CGFloat) -> NSLayoutConstraint
    {
        let myAnchor = anchor(for: yPosition)
        let targetAnchor = target.anchor(for: targetBaseline)
        
        let constraint = myAnchor.constraint(greaterThanOrEqualTo: targetAnchor,
                                             constant: minimumOffset)
        
        constraint.isActive = true
        
        return constraint
    }
}
