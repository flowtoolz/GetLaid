#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension LayoutView
{
    @discardableResult
    func constrainToParentFirstBaseline(offset: CGFloat = 0) -> NSLayoutConstraint?
    {
        constrain(to: parent?.firstBaseline.offset(offset))
    }
    
    @discardableResult
    func constrainToParentLastBaseline(offset: CGFloat = 0) -> NSLayoutConstraint?
    {
        constrain(to: parent?.lastBaseline.offset(offset))
    }
}
