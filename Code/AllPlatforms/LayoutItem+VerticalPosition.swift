extension LayoutItem
{
    // MARK: - Absolute Positioning
    
    @discardableResult
    public func constrain(above target: LayoutItem,
                          gap: CGFloat = 0) -> NSLayoutConstraint
    {
        return constrain(.bottom, to: .top, of: target, offset: -gap)
    }
    
    @discardableResult
    public func constrain(below target: LayoutItem,
                          gap: CGFloat = 0) -> NSLayoutConstraint
    {
        return constrain(.top, to: .bottom, of: target, offset: gap)
    }
    
    @discardableResult
    public func constrainTop(to target: LayoutItem,
                             offset: CGFloat = 0) -> NSLayoutConstraint
    {
        return constrain(.top, to: .top, of: target, offset: offset)
    }
    
    @discardableResult
    public func constrainBottom(to target: LayoutItem,
                                offset: CGFloat = 0) -> NSLayoutConstraint
    {
        return constrain(.bottom, to: .bottom, of: target, offset: offset)
    }
    
    @discardableResult
    public func constrainCenterY(to target: LayoutItem,
                                 offset: CGFloat = 0) -> NSLayoutConstraint
    {
        return constrain(.centerY, to: .centerY, of: target, offset: offset)
    }
    
    @discardableResult
    public func constrain(_ position: YPosition,
                          to targetPosition: YPosition,
                          of target: LayoutItem,
                          offset: CGFloat = 0) -> NSLayoutConstraint
    {
        let myAnchor = anchor(for: position)
        let targetAnchor = target.anchor(for: targetPosition)
        
        let constraint = myAnchor.constraint(equalTo: targetAnchor,
                                             constant: offset)
        
        constraint.isActive = true
        
        return constraint
    }
    
    func anchor(for yPosition: YPosition) -> NSLayoutYAxisAnchor
    {
        switch yPosition
        {
        case .top: return topAnchor
        case .centerY: return centerYAnchor
        case .bottom: return bottomAnchor
        }
    }
    
    // MARK: - Relative Positioning
    
    @discardableResult
    public func constrainTop(to relativePosition: CGFloat,
                             of target: LayoutItem) -> NSLayoutConstraint
    {
        return constrain(.top, to: relativePosition, of: target)
    }
    
    @discardableResult
    public func constrainBottom(to relativePosition: CGFloat,
                                of target: LayoutItem) -> NSLayoutConstraint
    {
        return constrain(.bottom, to: relativePosition, of: target)
    }
    
    @discardableResult
    public func constrainCenterY(to relativePosition: CGFloat,
                                 of target: LayoutItem) -> NSLayoutConstraint
    {
        return constrain(.centerY, to: relativePosition, of: target)
    }
    
    @discardableResult
    func constrain(_ position: YPosition,
                   to relativePosition: CGFloat,
                   of target: LayoutItem) -> NSLayoutConstraint
    {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: position.attribute,
                                            relatedBy: .equal,
                                            toItem: target,
                                            attribute: .bottom,
                                            multiplier: relativePosition,
                                            constant: 0)
        
        constraint.isActive = true
        
        return constraint
    }
}

public enum YPosition
{
    case top, centerY, bottom
    
    var attribute: LayoutAttribute
    {
        switch self
        {
        case .top: return .top
        case .centerY: return .centerY
        case .bottom: return .bottom
        }
    }
}
