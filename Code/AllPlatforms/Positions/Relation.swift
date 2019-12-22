#if os(OSX)
import AppKit
#else
import UIKit
#endif

public enum Relation {
    case exact
    case minimum
    case maximum
    case relative(CGFloat)
}
