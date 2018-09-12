extension LayoutItem
{
    @discardableResult
    public func constrainSize(to width: CGFloat,
                              _ height: CGFloat) -> [NSLayoutConstraint]
    {
        return [constrainWidth(to: width), constrainHeight(to: height)]
    }
    
    @discardableResult
    public func constrainSize<Target: LayoutItem>(to relativeWidth: CGFloat,
                                                  _ relativeHeight: CGFloat,
                                                  of target: Target) -> [NSLayoutConstraint]
    {
        return [ constrainWidth(to: relativeWidth, of: target),
                 constrainHeight(to: relativeHeight, of: target) ]
    }
}
