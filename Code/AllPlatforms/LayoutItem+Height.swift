extension LayoutItem
{
    // MARK: - Height
    
    @discardableResult
    public func constrainHeight(to size: CGFloat) -> NSLayoutConstraint
    {
        return constrain(.height, to: size)
    }
    
    @discardableResult
    public func constrainHeight(toMinimum minimum: CGFloat) -> NSLayoutConstraint
    {
        return constrain(.height, toMinimum: minimum)
    }
    
    @discardableResult
    public func constrainHeight(toMaximum maximum: CGFloat) -> NSLayoutConstraint
    {
        return constrain(.height, toMaximum: maximum)
    }
    
    @discardableResult
    public func constrainHeight<Target: LayoutItem>(to target: Target) -> NSLayoutConstraint
    {
        return constrain(.height, to: target)
    }
    
    @discardableResult
    public func constrainHeight<Target: LayoutItem>(to relativeSize: CGFloat,
                                                    of target: Target) -> NSLayoutConstraint
    {
        return constrain(.height, to: target, multiplier: relativeSize)
    }
}
