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
    @discardableResult
    func constrain(to target: LayoutItem) -> [NSLayoutConstraint]
    {
        [ constrainTop(to: target),
          constrainBottom(to: target),
          constrainLeft(to: target),
          constrainRight(to: target) ]
    }
}
