import UIKit.UIView
import UIKit.UILayoutGuide

public extension UIView
{
    @discardableResult
    func addForAutoLayout<View>(_ view: View) -> View where View: UIView
    {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        return view
    }
    
    func addLayoutGuide() -> UILayoutGuide
    {
        let guide = UILayoutGuide()
        
        addLayoutGuide(guide)
        
        return guide
    }
}
