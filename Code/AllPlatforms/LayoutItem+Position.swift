extension LayoutItem
{
    @discardableResult
    public func constrainCenter<Target: LayoutItem>(to target: Target) -> [NSLayoutConstraint]
    {
        return [constrainCenterX(to: target), constrainCenterY(to: target)]
    }
    
    @discardableResult
    public func constrain<Target: LayoutItem>(to target: Target,
                                              with insets: Insets = .zero) -> [NSLayoutConstraint]
    {
        return [ constrainTop(to: target, offset: insets.top),
                 constrainBottom(to: target, offset: -insets.bottom),
                 constrainLeft(to: target, offset: insets.left),
                 constrainRight(to: target, offset: -insets.right) ]
    }
}
