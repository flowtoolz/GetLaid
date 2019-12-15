#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension LayoutItem
{
    func anchor(for xPosition: XPosition) -> NSLayoutXAxisAnchor
    {
        switch xPosition
        {
        case .leading: return leadingAnchor
        case .centerX: return centerXAnchor
        case .trailing: return trailingAnchor
        case .left: return leftAnchor
        case .right: return rightAnchor
        }
    }
}

public enum XPosition
{
    case left, centerX, right, leading, trailing
    
    var attribute: LayoutAttribute
    {
        switch self
        {
        case .leading: return .leading
        case .centerX: return .centerX
        case .trailing: return .trailing
        case .left: return .left
        case .right: return .right
        }
    }
}
