import AppKit.NSView
import AppKit.NSLayoutGuide

public extension NSView
{
    func addForAutoLayout<View>(_ view: View) -> View where View: NSView
    {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        return view
    }
    
    func addLayoutGuide() -> NSLayoutGuide
    {
        let guide = NSLayoutGuide()
        
        addLayoutGuide(guide)
        
        return guide
    }
}
