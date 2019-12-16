#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension LayoutItem
{
    func constrain(_ dimension: Dimension,
                   to size: CGFloat) -> NSLayoutConstraint
    {
        anchor(for: dimension).constraint(equalToConstant: size).activate()
    }
    
    func constrain(_ dimension: Dimension,
                   toMinimum minimum: CGFloat) -> NSLayoutConstraint
    {
        anchor(for: dimension).constraint(greaterThanOrEqualToConstant: minimum).activate()
    }

    func constrain(_ dimension: Dimension,
                   toMaximum maximum: CGFloat) -> NSLayoutConstraint
    {
        anchor(for: dimension).constraint(lessThanOrEqualToConstant: maximum).activate()
    }
    
    func constrain(_ dimension: Dimension,
                   to target: LayoutItem,
                   factor: CGFloat = 1) -> NSLayoutConstraint
    {
        constrain(dimension, to: dimension, of: target, factor: factor)
    }
    
    func constrain(_ dimension: Dimension,
                   to targetDimension: Dimension,
                   of target: LayoutItem,
                   factor: CGFloat = 1) -> NSLayoutConstraint
    {
        anchor(for: dimension).constraint(equalTo: target.anchor(for: targetDimension),
                                          multiplier: factor).activate()
    }
}
