#if os(macOS)
import AppKit

public extension NSView
{
    @discardableResult
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

#endif
