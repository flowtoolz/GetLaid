import AppKit

extension NSLayoutGuide: LayoutItem {}
extension NSView: LayoutItem {}

// MARK: -

extension LayoutItem
{
    // MARK: Position
    
    @discardableResult
    public func constrainCenter<Target: LayoutItem>(to target: Target) -> [NSLayoutConstraint]
    {
        return [constrainCenterX(to: target), constrainCenterY(to: target)]
    }
    
    @discardableResult
    public func constrain<Target: LayoutItem>(to target: Target,
                                              with insets: NSEdgeInsets = NSEdgeInsetsZero) -> [NSLayoutConstraint]
    {
        return [ constrainTop(to: target, offset: insets.top),
                 constrainBottom(to: target, offset: -insets.bottom),
                 constrainLeft(to: target, offset: insets.left),
                 constrainRight(to: target, offset: -insets.right) ]
    }
    
    // MARK: Horizontal Position
    
    @discardableResult
    public func constrain<Target: LayoutItem>(toTheLeftOf target: Target,
                                              offset: CGFloat = 0) -> NSLayoutConstraint
    {
        return constrain(.right, to: .left, of: target, offset: offset)
    }
    
    @discardableResult
    public func constrain<Target: LayoutItem>(toTheRightOf target: Target,
                                              offset: CGFloat = 0) -> NSLayoutConstraint
    {
        return constrain(.left, to: .right, of: target, offset: offset)
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
    
    // MARK: Vertical Position
    
    @discardableResult
    public func constrain<Target: LayoutItem>(above target: Target,
                                              offset: CGFloat = 0) -> NSLayoutConstraint
    {
        return constrain(.bottom, to: .top, of: target, offset: offset)
    }
    
    @discardableResult
    public func constrain<Target: LayoutItem>(below target: Target,
                                              offset: CGFloat = 0) -> NSLayoutConstraint
    {
        return constrain(.top, to: .bottom, of: target, offset: offset)
    }
    
    @discardableResult
    public func constrainTop<Target: LayoutItem>(to target: Target,
                                                 offset: CGFloat = 0) -> NSLayoutConstraint
    {
        return constrain(.top, to: .top, of: target, offset: offset)
    }
    
    @discardableResult
    public func constrainBottom<Target: LayoutItem>(to target: Target,
                                                    offset: CGFloat = 0) -> NSLayoutConstraint
    {
        return constrain(.bottom, to: .bottom, of: target, offset: offset)
    }
    
    @discardableResult
    public func constrainCenterY<Target: LayoutItem>(to target: Target,
                                                     offset: CGFloat = 0) -> NSLayoutConstraint
    {
        return constrain(.centerY, to: .centerY, of: target, offset: offset)
    }
    
    @discardableResult
    func constrain<Target: LayoutItem>(_ position: YPosition,
                                       to targetPosition: YPosition,
                                       of target: Target,
                                       offset: CGFloat = 0) -> NSLayoutConstraint
    {
        let myAnchor = anchor(for: position)
        let targetAnchor = target.anchor(for: targetPosition)
        
        let constraint = myAnchor.constraint(equalTo: targetAnchor, constant: offset)
        
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
    
    @discardableResult
    public func constrainTop<Target: LayoutItem>(to relativePosition: CGFloat,
                                                 of target: Target) -> NSLayoutConstraint
    {
        return constrain(.top, to: relativePosition, of: target)
    }
    
    @discardableResult
    public func constrainBottom<Target: LayoutItem>(to relativePosition: CGFloat,
                                                    of target: Target) -> NSLayoutConstraint
    {
        return constrain(.bottom, to: relativePosition, of: target)
    }
    
    @discardableResult
    func constrain<Target: LayoutItem>(_ position: YPosition,
                                       to relativePosition: CGFloat,
                                       of target: Target) -> NSLayoutConstraint
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
    
    // MARK: Size
    
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
    
    // MARK: Width
    
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
    
    // MARK: Height
    
    @discardableResult
    public func constrainHeight(to height: CGFloat) -> NSLayoutConstraint
    {
        return constrain(.height, to: height)
    }
    
    @discardableResult
    public func constrainHeight(toMinimum minimum: CGFloat) -> NSLayoutConstraint
    {
        return constrain(.height, toMinimum: minimum)
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
    
    // MARK: Size
    
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

// MARK: -

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

enum YPosition
{
    case top, centerY, bottom
    
    var attribute: NSLayoutConstraint.Attribute
    {
        switch self
        {
        case .top: return .top
        case .centerY: return .centerY
        case .bottom: return .bottom
        }
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

// MARK: -

public protocol LayoutItem
{
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    
    var topAnchor: NSLayoutYAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
}
