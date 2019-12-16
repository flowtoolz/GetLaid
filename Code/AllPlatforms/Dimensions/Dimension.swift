#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension LayoutItem
{
    func anchor(for dimension: Dimension) -> NSLayoutDimension
    {
        dimension == .width ? widthAnchor : heightAnchor
    }
}

enum Dimension { case width, height }
