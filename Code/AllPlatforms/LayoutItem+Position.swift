extension LayoutItem
{
    @discardableResult
    public func constrainCenter(to target: LayoutItem) -> [NSLayoutConstraint]
    {
        return [constrainCenterX(to: target), constrainCenterY(to: target)]
    }
    
    @discardableResult
    public func constrain(to target: LayoutItem) -> [NSLayoutConstraint]
    {
        return [ constrainTop(to: target),
                 constrainBottom(to: target),
                 constrainLeft(to: target),
                 constrainRight(to: target) ]
    }
}
