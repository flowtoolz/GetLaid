#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    @discardableResult
    func constrainToParentExcludingLeft(inset: CGFloat) -> [NSLayoutConstraint]
    {
        constrainToParentExcludingLeft(insetTop: inset,
                                       insetBottom: inset,
                                       insetRight: inset)
    }
    
    @discardableResult
    func constrainToParentExcludingLeft(insetTop: CGFloat = 0,
                                        insetBottom: CGFloat = 0,
                                        insetRight: CGFloat = 0) -> [NSLayoutConstraint]
    {
        parent.map
        {
            constrainExcludingLeft(to: $0,
                                   offsetTop: insetTop,
                                   offsetBottom: -insetBottom,
                                   offsetRight: -insetRight)
        } ?? []
    }
    
    @discardableResult
    func constrainToParentExcludingRight(inset: CGFloat) -> [NSLayoutConstraint]
    {
        constrainToParentExcludingRight(insetTop: inset,
                                        insetLeft: inset,
                                        insetBottom: inset)
    }
    
    @discardableResult
    func constrainToParentExcludingRight(insetTop: CGFloat = 0,
                                         insetLeft: CGFloat = 0,
                                         insetBottom: CGFloat = 0) -> [NSLayoutConstraint]
    {
        parent.map
        {
            constrainExcludingRight(to: $0,
                                    offsetTop: insetTop,
                                    offsetLeft: insetLeft,
                                    offsetBottom: -insetBottom)
        } ?? []
    }
    
    @discardableResult
    func constrainToParentExcludingTop(inset: CGFloat) -> [NSLayoutConstraint]
    {
        constrainToParentExcludingTop(insetLeading: inset,
                                      insetBottom: inset,
                                      insetTrailing: inset)
    }
    
    @discardableResult
    func constrainToParentExcludingTop(insetLeft: CGFloat,
                                       insetBottom: CGFloat = 0,
                                       insetRight: CGFloat) -> [NSLayoutConstraint]
    {
        parent.map
        {
            constrainExcludingTop(to: $0,
                                  offsetLeft: insetLeft,
                                  offsetBottom: -insetBottom,
                                  offsetRight: -insetRight)
        } ?? []
    }
    
    @discardableResult
    func constrainToParentExcludingTop(insetLeading: CGFloat = 0,
                                       insetBottom: CGFloat = 0,
                                       insetTrailing: CGFloat = 0) -> [NSLayoutConstraint]
    {
        parent.map
        {
            constrainExcludingTop(to: $0,
                                  offsetLeading: insetLeading,
                                  offsetBottom: -insetBottom,
                                  offsetTrailing: -insetTrailing)
        } ?? []
    }
    
    @discardableResult
    func constrainToParentExcludingLeading(inset: CGFloat) -> [NSLayoutConstraint]
    {
        constrainToParentExcludingLeading(insetTop: inset,
                                          insetBottom: inset,
                                          insetTrailing: inset)
    }
    
    @discardableResult
    func constrainToParentExcludingLeading(insetTop: CGFloat = 0,
                                           insetBottom: CGFloat = 0,
                                           insetTrailing: CGFloat = 0) -> [NSLayoutConstraint]
    {
        parent.map
        {
            constrainExcludingLeading(to: $0,
                                      offsetTop: insetTop,
                                      offsetBottom: -insetBottom,
                                      offsetTrailing: -insetTrailing)
        } ?? []
    }
    
    @discardableResult
    func constrainToParentExcludingBottom(inset: CGFloat) -> [NSLayoutConstraint]
    {
        constrainToParentExcludingBottom(insetTop: inset,
                                         insetLeading: inset,
                                         insetTrailing: inset)
    }
    
    @discardableResult
    func constrainToParentExcludingBottom(insetTop: CGFloat = 0,
                                          insetLeft: CGFloat,
                                          insetRight: CGFloat) -> [NSLayoutConstraint]
    {
        parent.map
        {
            constrainExcludingBottom(to: $0,
                                     offsetTop: insetTop,
                                     offsetLeft: insetLeft,
                                     offsetRight: -insetRight)
        } ?? []
    }
    
    @discardableResult
    func constrainToParentExcludingBottom(insetTop: CGFloat = 0,
                                          insetLeading: CGFloat = 0,
                                          insetTrailing: CGFloat = 0) -> [NSLayoutConstraint]
    {
        parent.map
        {
            constrainExcludingBottom(to: $0,
                                     offsetTop: insetTop,
                                     offsetLeading: insetLeading,
                                     offsetTrailing: -insetTrailing)
        } ?? []
    }
    
    @discardableResult
    func constrainToParentExcludingTrailing(inset: CGFloat) -> [NSLayoutConstraint]
    {
        constrainToParentExcludingTrailing(insetTop: inset,
                                           insetLeading: inset,
                                           insetBottom: inset)
    }
    
    @discardableResult
    func constrainToParentExcludingTrailing(insetTop: CGFloat = 0,
                                            insetLeading: CGFloat = 0,
                                            insetBottom: CGFloat = 0) -> [NSLayoutConstraint]
    {
        parent.map
        {
            constrainExcludingTrailing(to: $0,
                                       offsetTop: insetTop,
                                       offsetLeading: insetLeading,
                                       offsetBottom: -insetBottom)
        } ?? []
    }
}

public extension LayoutItem
{
    @discardableResult
    func constrainExcludingLeft(to target: LayoutItem,
                                offsetTop: CGFloat = 0,
                                offsetBottom: CGFloat = 0,
                                offsetRight: CGFloat = 0) -> [NSLayoutConstraint]
    {
        [ constrainTop(to: target, offset: offsetTop),
          constrainBottom(to: target, offset: offsetBottom),
          constrainRight(to: target, offset: offsetRight) ]
    }
    
    @discardableResult
    func constrainExcludingRight(to target: LayoutItem,
                                 offsetTop: CGFloat = 0,
                                 offsetLeft: CGFloat = 0,
                                 offsetBottom: CGFloat = 0) -> [NSLayoutConstraint]
    {
        [ constrainTop(to: target, offset: offsetTop),
          constrainLeft(to: target, offset: offsetLeft),
          constrainBottom(to: target, offset: offsetBottom)]
    }
    
    @discardableResult
    func constrainExcludingTop(to target: LayoutItem,
                              offsetLeft: CGFloat,
                              offsetBottom: CGFloat = 0,
                              offsetRight: CGFloat) -> [NSLayoutConstraint]
    {
        [ constrainLeft(to: target, offset: offsetLeft),
          constrainBottom(to: target, offset: offsetBottom),
          constrainRight(to: target, offset: offsetRight) ]
    }
    
    @discardableResult
    func constrainExcludingTop(to target: LayoutItem,
                              offsetLeading: CGFloat = 0,
                              offsetBottom: CGFloat = 0,
                              offsetTrailing: CGFloat = 0) -> [NSLayoutConstraint]
    {
        [ constrainLeading(to: target, offset: offsetLeading),
          constrainBottom(to: target, offset: offsetBottom),
          constrainTrailing(to: target, offset: offsetTrailing) ]
    }
    
    @discardableResult
    func constrainExcludingLeading(to target: LayoutItem,
                                   offsetTop: CGFloat = 0,
                                   offsetBottom: CGFloat = 0,
                                   offsetTrailing: CGFloat = 0) -> [NSLayoutConstraint]
    {
        [ constrainTop(to: target, offset: offsetTop),
          constrainBottom(to: target, offset: offsetBottom),
          constrainTrailing(to: target, offset: offsetTrailing) ]
    }
    
    @discardableResult
    func constrainExcludingBottom(to target: LayoutItem,
                                  offsetTop: CGFloat = 0,
                                  offsetLeft: CGFloat,
                                  offsetRight: CGFloat) -> [NSLayoutConstraint]
    {
        [ constrainTop(to: target, offset: offsetTop),
          constrainLeft(to: target, offset: offsetLeft),
          constrainRight(to: target, offset: offsetRight) ]
    }
    
    @discardableResult
    func constrainExcludingBottom(to target: LayoutItem,
                                  offsetTop: CGFloat = 0,
                                  offsetLeading: CGFloat = 0,
                                  offsetTrailing: CGFloat = 0) -> [NSLayoutConstraint]
    {
        [ constrainTop(to: target, offset: offsetTop),
          constrainLeading(to: target, offset: offsetLeading),
          constrainTrailing(to: target, offset: offsetTrailing) ]
    }
    
    @discardableResult
    func constrainExcludingTrailing(to target: LayoutItem,
                                    offsetTop: CGFloat = 0,
                                    offsetLeading: CGFloat = 0,
                                    offsetBottom: CGFloat = 0) -> [NSLayoutConstraint]
    {
        [ constrainTop(to: target, offset: offsetTop),
          constrainLeading(to: target, offset: offsetLeading),
          constrainBottom(to: target, offset: offsetBottom) ]
    }
}
