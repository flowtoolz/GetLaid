#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension LayoutItem
{
    func anchor(for yPosition: YPosition) -> NSLayoutYAxisAnchor
    {
        switch yPosition
        {
        case .top: return topAnchor
        case .centerY: return centerYAnchor
        case .bottom: return bottomAnchor
        }
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
