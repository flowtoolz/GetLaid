extension LayoutItem
{
    @discardableResult
    public func constrainWidth(to width: CGFloat) -> NSLayoutConstraint
    {
        return constrain(.width, to: width)
    }
    
    @discardableResult
    public func constrainWidth(toMinimum minimum: CGFloat) -> NSLayoutConstraint
    {
        return constrain(.width, toMinimum: minimum)
    }
    
    @discardableResult
    public func constrainWidth<Target: LayoutItem>(to target: Target) -> NSLayoutConstraint
    {
        return constrain(.width, to: target)
    }
    
    @discardableResult
    public func constrainWidth<Target: LayoutItem>(to relativeSize: CGFloat,
                                                   of target: Target) -> NSLayoutConstraint
    {
        return constrain(.width, to: target, multiplier: relativeSize)
    }
}
