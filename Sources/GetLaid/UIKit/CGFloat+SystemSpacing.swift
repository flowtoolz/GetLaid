#if os(iOS) || os(tvOS)
import UIKit

@available(iOS 11.0, *)
public var systemSpacing: CGFloat { systemSiblingSpacing }

@available(iOS 11.0, *)
public let systemSiblingSpacing: CGFloat =
{
    let view = UIView()
    let subview = UIView()
    let subview2 = UIView()
    view.addForAutoLayout(subview)
    view.addForAutoLayout(subview2)
    return subview2.leftAnchor.constraint(equalToSystemSpacingAfter: subview.rightAnchor,
                                          multiplier: 1).constant
}()

@available(iOS 11.0, *)
public let systemParentSpacing: CGFloat =
{
    let view = UIView()
    let subview = UIView()
    view.addForAutoLayout(subview)
    return subview.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor,
                                         multiplier: 1).constant
}()

#endif
