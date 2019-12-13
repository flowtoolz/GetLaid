import UIKit

@available(iOS 11.0, *)
public extension CGFloat
{
    static let systemSpacing: CGFloat =
    {
        let view = UIView()
        let subview = UIView()
        view.addForAutoLayout(subview)
        return subview.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor,
                                             multiplier: 1).constant
    }()
}
