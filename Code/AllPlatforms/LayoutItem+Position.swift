extension LayoutItem
{
    @discardableResult
    public func constrainCenter<Target: LayoutItem>(to target: Target) -> [NSLayoutConstraint]
    {
        return [constrainCenterX(to: target), constrainCenterY(to: target)]
    }
    
    @discardableResult
    public func constrain<Target: LayoutItem>(to target: Target) -> [NSLayoutConstraint]
    {
        return [ constrainTop(to: target),
                 constrainBottom(to: target),
                 constrainLeft(to: target),
                 constrainRight(to: target) ]
    }
}
