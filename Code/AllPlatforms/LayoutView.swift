public protocol LayoutView: LayoutItem
{
    var parent: LayoutView? { get }
    
    var firstBaselineAnchor: NSLayoutYAxisAnchor { get }
    var lastBaselineAnchor: NSLayoutYAxisAnchor { get }
}
