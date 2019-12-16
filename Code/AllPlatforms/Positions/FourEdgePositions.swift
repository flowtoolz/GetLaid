#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    @discardableResult
    func constrainToParent(inset: CGFloat) -> [NSLayoutConstraint]
    {
        constrainToParent(insetTop: inset,
                          insetLeading: inset,
                          insetBottom: inset,
                          insetTrailing: inset)
    }
        
    @discardableResult
    func constrainToParent(insetTop: CGFloat = 0,
                           insetLeft: CGFloat,
                           insetBottom: CGFloat = 0,
                           insetRight: CGFloat) -> [NSLayoutConstraint]
    {
        parent.map
        {
            constrain(to: $0,
                      offsetTop: insetTop,
                      offsetLeft: insetLeft,
                      offsetBottom: -insetBottom,
                      offsetRight: -insetRight)
        } ?? []
    }
    
    @discardableResult
    func constrainToParent(insetTop: CGFloat = 0,
                           insetLeading: CGFloat = 0,
                           insetBottom: CGFloat = 0,
                           insetTrailing: CGFloat = 0) -> [NSLayoutConstraint]
    {
        parent.map
        {
            constrain(to: $0,
                      offsetTop: insetTop,
                      offsetLeading: insetLeading,
                      offsetBottom: -insetBottom,
                      offsetTrailing: -insetTrailing)
        } ?? []
    }
}

public extension LayoutItem
{
    @discardableResult
    func constrain(to target: LayoutItem,
                   offsetTop: CGFloat = 0,
                   offsetLeft: CGFloat,
                   offsetBottom: CGFloat = 0,
                   offsetRight: CGFloat) -> [NSLayoutConstraint]
    {
        [ constrainTop(to: target, offset: offsetTop),
          constrainLeft(to: target, offset: offsetLeft),
          constrainBottom(to: target, offset: offsetBottom),
          constrainRight(to: target, offset: offsetRight) ]
    }
    
    @discardableResult
    func constrain(to target: LayoutItem,
                   offsetTop: CGFloat = 0,
                   offsetLeading: CGFloat = 0,
                   offsetBottom: CGFloat = 0,
                   offsetTrailing: CGFloat = 0) -> [NSLayoutConstraint]
    {
        [ constrainTop(to: target, offset: offsetTop),
          constrainLeading(to: target, offset: offsetLeading),
          constrainBottom(to: target, offset: offsetBottom),
          constrainTrailing(to: target, offset: offsetTrailing) ]
    }
}
