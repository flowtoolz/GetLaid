extension LayoutItem
{
    // MARK: - Absolute Positioning
    
    @discardableResult
    public func constrain<Target: LayoutItem>(toTheLeftOf target: Target,
                                              gap: CGFloat = 0) -> NSLayoutConstraint
    {
        return constrain(.right, to: .left, of: target, offset: -gap)
    }
    
    @discardableResult
    public func constrain<Target: LayoutItem>(toTheRightOf target: Target,
                                              gap: CGFloat = 0) -> NSLayoutConstraint
    {
        return constrain(.left, to: .right, of: target, offset: gap)
    }
    
    @discardableResult
    public func constrainLeft<Target: LayoutItem>(to target: Target,
                                                  offset: CGFloat = 0) -> NSLayoutConstraint
    {
        return constrain(.left, to: .left, of: target, offset: offset)
    }
    
    @discardableResult
    public func constrainRight<Target: LayoutItem>(to target: Target,
                                                   offset: CGFloat = 0) -> NSLayoutConstraint
    {
        return constrain(.right, to: .right, of: target, offset: offset)
    }
    
    @discardableResult
    public func constrainCenterX<Target: LayoutItem>(to target: Target,
                                                     offset: CGFloat = 0) -> NSLayoutConstraint
    {
        return constrain(.centerX, to: .centerX, of: target, offset: offset)
    }
    
    @discardableResult
    func constrain<Target: LayoutItem>(_ position: XPosition,
                                       to targetPosition: XPosition,
                                       of target: Target,
                                       offset: CGFloat = 0) -> NSLayoutConstraint
    {
        let myAnchor = anchor(for: position)
        let targetAnchor = target.anchor(for: targetPosition)
        
        let constraint = myAnchor.constraint(equalTo: targetAnchor, constant: offset)
        
        constraint.isActive = true
        
        return constraint
    }
    
    func anchor(for xPosition: XPosition) -> NSLayoutXAxisAnchor
    {
        switch xPosition
        {
        case .left: return leftAnchor
        case .centerX: return centerXAnchor
        case .right: return rightAnchor
        }
    }
    
    // MARK: - Relative Positioning
    
    @discardableResult
    public func constrainLeft<Target: LayoutItem>(to relativePosition: CGFloat,
                                                  of target: Target) -> NSLayoutConstraint
    {
        return constrain(.left, to: relativePosition, of: target)
    }
    
    @discardableResult
    public func constrainRight<Target: LayoutItem>(to relativePosition: CGFloat,
                                                   of target: Target) -> NSLayoutConstraint
    {
        return constrain(.right, to: relativePosition, of: target)
    }
    
    @discardableResult
    public func constrainCenterX<Target: LayoutItem>(to relativePosition: CGFloat,
                                                     of target: Target) -> NSLayoutConstraint
    {
        return constrain(.centerX, to: relativePosition, of: target)
    }
    
    @discardableResult
    func constrain<Target: LayoutItem>(_ position: XPosition,
                                       to relativePosition: CGFloat,
                                       of target: Target) -> NSLayoutConstraint
    {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: position.attribute,
                                            relatedBy: .equal,
                                            toItem: target,
                                            attribute: .right,
                                            multiplier: relativePosition,
                                            constant: 0)
        
        constraint.isActive = true
        
        return constraint
    }
}

enum XPosition
{
    case left, centerX, right
    
    var attribute: NSLayoutConstraint.Attribute
    {
        switch self
        {
        case .left: return .left
        case .centerX: return .centerX
        case .right: return .right
        }
    }
}
