#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    // MARK: - Absolute Positioning

    @discardableResult
    func constrainToParent(inset: CGFloat) -> [NSLayoutConstraint]
    {
        constrainToParent(insetTop: inset,
                          insetLeft: inset,
                          insetBottom: inset,
                          insetRight: inset)
    }
        
    @discardableResult
    func constrainToParent(insetTop: CGFloat = 0,
                           insetLeft: CGFloat,
                           insetBottom: CGFloat = 0,
                           insetRight: CGFloat) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainTop(to: parent, offset: insetTop),
                 constrainBottom(to: parent, offset: -insetBottom),
                 constrainLeft(to: parent, offset: insetLeft),
                 constrainRight(to: parent, offset: -insetRight) ]
    }
    
    @discardableResult
    func constrainToParent(insetTop: CGFloat = 0,
                           insetLeading: CGFloat = 0,
                           insetBottom: CGFloat = 0,
                           insetTrailing: CGFloat = 0) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainTop(to: parent, offset: insetTop),
                 constrainBottom(to: parent, offset: -insetBottom),
                 constrainLeading(to: parent, offset: insetLeading),
                 constrainTrailing(to: parent, offset: -insetTrailing) ]
    }
    
    @discardableResult
    func constrainToParentExcludingTop(inset: CGFloat) -> [NSLayoutConstraint]
    {
        constrainToParentExcludingTop(insetLeft: inset,
                                      insetBottom: inset,
                                      insetRight: inset)
    }
    
    @discardableResult
    func constrainToParentExcludingTop(insetLeft: CGFloat,
                                       insetBottom: CGFloat = 0,
                                       insetRight: CGFloat) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainBottom(to: parent, offset: -insetBottom),
                 constrainLeft(to: parent, offset: insetLeft),
                 constrainRight(to: parent, offset: -insetRight) ]
    }
    
    @discardableResult
    func constrainToParentExcludingTop(insetLeading: CGFloat = 0,
                                       insetBottom: CGFloat = 0,
                                       insetTrailing: CGFloat = 0) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainBottom(to: parent, offset: -insetBottom),
                 constrainLeading(to: parent, offset: insetLeading),
                 constrainRight(to: parent, offset: -insetTrailing) ]
    }
    
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
                                        insetRight: CGFloat) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainBottom(to: parent, offset: -insetBottom),
                 constrainTop(to: parent, offset: insetTop),
                 constrainRight(to: parent, offset: -insetRight) ]
    }
    
    @discardableResult
    func constrainToParentExcludingLeft(insetTop: CGFloat = 0,
                                        insetBottom: CGFloat = 0,
                                        insetTrailing: CGFloat = 0) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainBottom(to: parent, offset: -insetBottom),
                 constrainTop(to: parent, offset: insetTop),
                 constrainTrailing(to: parent, offset: -insetTrailing) ]
    }
    
    @discardableResult
    func constrainToParentExcludingBottom(inset: CGFloat) -> [NSLayoutConstraint]
    {
        constrainToParentExcludingBottom(insetTop: inset,
                                         insetLeft: inset,
                                         insetRight: inset)
    }
    
    @discardableResult
    func constrainToParentExcludingBottom(insetTop: CGFloat = 0,
                                          insetLeft: CGFloat,
                                          insetRight: CGFloat) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainRight(to: parent, offset: -insetRight),
                 constrainTop(to: parent, offset: insetTop),
                 constrainLeft(to: parent, offset: insetLeft) ]
    }
    
    @discardableResult
    func constrainToParentExcludingBottom(insetTop: CGFloat = 0,
                                          insetLeading: CGFloat = 0,
                                          insetTrailing: CGFloat = 0) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainTrailing(to: parent, offset: -insetTrailing),
                 constrainTop(to: parent, offset: insetTop),
                 constrainLeading(to: parent, offset: insetLeading) ]
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
                                         insetLeft: CGFloat,
                                         insetBottom: CGFloat = 0) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainBottom(to: parent, offset: -insetBottom),
                 constrainTop(to: parent, offset: insetTop),
                 constrainLeft(to: parent, offset: insetLeft) ]
    }
    
    @discardableResult
    func constrainToParentExcludingRight(insetTop: CGFloat = 0,
                                         insetLeading: CGFloat = 0,
                                         insetBottom: CGFloat = 0) -> [NSLayoutConstraint]
    {
        guard let parent = parent else { return [] }
        
        return [ constrainBottom(to: parent, offset: -insetBottom),
                 constrainTop(to: parent, offset: insetTop),
                 constrainLeading(to: parent, offset: insetLeading) ]
    }
}

public extension LayoutItem
{
    // MARK: - Three Edges
    
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
    func constrainExludingTop(to target: LayoutItem,
                              offsetLeft: CGFloat,
                              offsetBottom: CGFloat = 0,
                              offsetRight: CGFloat) -> [NSLayoutConstraint]
    {
        [ constrainLeft(to: target, offset: offsetLeft),
          constrainBottom(to: target, offset: offsetBottom),
          constrainRight(to: target, offset: offsetRight) ]
    }
    
    @discardableResult
    func constrainExludingTop(to target: LayoutItem,
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
    
    // MARK: - Four Edges
    
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
