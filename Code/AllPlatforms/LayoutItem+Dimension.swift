extension LayoutItem
{
    @discardableResult
    func constrain(_ dimension: Dimension,
                   to size: CGFloat) -> NSLayoutConstraint
    {
        let myAnchor = anchor(for: dimension)
        
        let constraint = myAnchor.constraint(equalToConstant: size)
        
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func constrain(_ dimension: Dimension,
                   toMinimum minimum: CGFloat) -> NSLayoutConstraint
    {
        let myAnchor = anchor(for: dimension)
        
        let constraint = myAnchor.constraint(greaterThanOrEqualToConstant: minimum)
        
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func constrain<Target: LayoutItem>(_ dimension: Dimension,
                                       to target: Target,
                                       multiplier: CGFloat = 1) -> NSLayoutConstraint
    {
        let myAnchor = anchor(for: dimension)
        let targetAnchor = target.anchor(for: dimension)
        
        let constraint = myAnchor.constraint(equalTo: targetAnchor,
                                             multiplier: multiplier)
        
        constraint.isActive = true
        
        return constraint
    }
    
    func anchor(for dimension: Dimension) -> NSLayoutDimension
    {
        return dimension == .width ? widthAnchor : heightAnchor
    }
}

enum Dimension
{
    case width, height
    
    var attribute: NSLayoutConstraint.Attribute
    {
        return self == .width ? .width : .height
    }
}
