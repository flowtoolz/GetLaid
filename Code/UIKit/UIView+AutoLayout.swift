import UIKit.UIView
import UIKit.UILayoutGuide

public extension UIView
{
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
    
    func addLayoutGuides(_ number: Int) -> [UILayoutGuide]
    {
        guard number > 0 else { return [] }
        
        var guides = [UILayoutGuide]()
        
        for _ in 0 ..< number
        {
            let guide = UILayoutGuide()
            
            addLayoutGuide(guide)
            
            guides.append(guide)
        }
        
        return guides
    }
}
