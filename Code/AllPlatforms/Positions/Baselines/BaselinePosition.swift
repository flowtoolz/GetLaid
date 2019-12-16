#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension LayoutView
{
    func anchor(for baselinePosition: BaselinePosition) -> NSLayoutYAxisAnchor
    {
        switch baselinePosition
        {
        case .firstBaseline: return firstBaselineAnchor
        case .lastBaseline: return lastBaselineAnchor
        }
    }
}

public enum BaselinePosition
{
    case firstBaseline, lastBaseline
    
    var attribute: LayoutAttribute
    {
        switch self
        {
        case .firstBaseline: return .firstBaseline
        case .lastBaseline: return .lastBaseline
        }
    }
}
