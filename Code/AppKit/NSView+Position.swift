import AppKit.NSView

extension NSView
{
    // MARK: - Absolute Positioning
    
    @discardableResult
    public func constrainCenterToParent() -> [NSLayoutConstraint]
    {
        guard let parent = superview else { return [] }
        
        return [constrainCenterX(to: parent), constrainCenterY(to: parent)]
    }
    
    @discardableResult
    public func constrainToParent(insets: Insets = .zero) -> [NSLayoutConstraint]
    {
        guard let parent = superview else { return [] }
        
        return [ constrainTop(to: parent, offset: insets.top),
                 constrainBottom(to: parent, offset: -insets.bottom),
                 constrainLeft(to: parent, offset: insets.left),
                 constrainRight(to: parent, offset: -insets.right) ]
    }
    
    @discardableResult
    public func constrainTopToParent(inset: CGFloat = 0) -> NSLayoutConstraint?
    {
        guard let parent = superview else { return nil }
        
        return constrainTop(to: parent, offset: inset)
    }
    
    @discardableResult
    public func constrainBottomToParent(inset: CGFloat = 0) -> NSLayoutConstraint?
    {
        guard let parent = superview else { return nil }
        
        return constrainBottom(to: parent, offset: -inset)
    }
    
    @discardableResult
    public func constrainCenterYToParent(offset: CGFloat = 0) -> NSLayoutConstraint?
    {
        guard let parent = superview else { return nil }
        
        return constrainCenterY(to: parent, offset: offset)
    }
    
    @discardableResult
    public func constrainLeftToParent(inset: CGFloat = 0) -> NSLayoutConstraint?
    {
        guard let parent = superview else { return nil }
        
        return constrainLeft(to: parent, offset: inset)
    }
    
    @discardableResult
    public func constrainRightToParent(inset: CGFloat = 0) -> NSLayoutConstraint?
    {
        guard let parent = superview else { return nil }
        
        return constrainRight(to: parent, offset: -inset)
    }
    
    @discardableResult
    public func constrainCenterXToParent(offset: CGFloat = 0) -> NSLayoutConstraint?
    {
        guard let parent = superview else { return nil }
        
        return constrainCenterX(to: parent, offset: offset)
    }
    
    // MARK: - Relative Positioning
    
    @discardableResult
    public func constrainTopToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = superview else { return nil }
        
        return constrainTop(to: fraction, of: parent)
    }
    
    @discardableResult
    public func constrainBottomToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = superview else { return nil }
        
        return constrainBottom(to: fraction, of: parent)
    }
    
    @discardableResult
    public func constrainCenterYToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = superview else { return nil }
        
        return constrainCenterY(to: fraction, of: parent)
    }
    
    @discardableResult
    public func constrainLeftToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = superview else { return nil }
        
        return constrainLeft(to: fraction, of: parent)
    }
    
    @discardableResult
    public func constrainRightToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = superview else { return nil }
        
        return constrainRight(to: fraction, of: parent)
    }
    
    @discardableResult
    public func constrainCenterXToParent(at fraction: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = superview else { return nil }
        
        return constrainCenterX(to: fraction, of: parent)
    }
}
