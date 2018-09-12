extension NSView
{
    // MARK: - Absolute Sizing
    
    @discardableResult
    public func constrainSizeToParent() -> [NSLayoutConstraint]
    {
        guard let parent = superview else { return [] }
        
        return [constrainWidth(to: parent), constrainHeight(to: parent) ]
    }
    
    @discardableResult
    public func constrainWidthToParent() -> NSLayoutConstraint?
    {
        guard let parent = superview else { return nil }
        
        return constrainWidth(to: parent)
    }
    
    @discardableResult
    public func constrainHeightToParent() -> NSLayoutConstraint?
    {
        guard let parent = superview else { return nil }
        
        return constrainHeight(to: parent)
    }
    
    // MARK: - Relative Sizing
    
    @discardableResult
    public func constrainWidth(toParentWith relativeSize: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = superview else { return nil }
        
        return constrain(.width, to: parent, multiplier: relativeSize)
    }
    
    @discardableResult
    public func constrainHeight(toParentWith relativeSize: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = superview else { return nil }
        
        return constrain(.height, to: parent, multiplier: relativeSize)
    }
    
    @discardableResult
    public func constrainSize(toParentWith relativeWidth: CGFloat,
                              _ relativeHeight: CGFloat) -> [NSLayoutConstraint]
    {
        guard let parent = superview else { return [] }
        
        return [ constrainWidth(to: relativeWidth, of: parent),
                 constrainHeight(to: relativeHeight, of: parent) ]
    }
}
