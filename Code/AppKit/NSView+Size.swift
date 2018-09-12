import AppKit.NSView

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
    public func constrainWidthToParent(with relativeSize: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = superview else { return nil }
        
        return constrain(.width, to: parent, multiplier: relativeSize)
    }
    
    @discardableResult
    public func constrainHeightToParent(with relativeSize: CGFloat) -> NSLayoutConstraint?
    {
        guard let parent = superview else { return nil }
        
        return constrain(.height, to: parent, multiplier: relativeSize)
    }
    
    @discardableResult
    public func constrainSizeToParent(with relativeWidth: CGFloat,
                              _ relativeHeight: CGFloat) -> [NSLayoutConstraint]
    {
        guard let parent = superview else { return [] }
        
        return [ constrainWidth(to: relativeWidth, of: parent),
                 constrainHeight(to: relativeHeight, of: parent) ]
    }
}