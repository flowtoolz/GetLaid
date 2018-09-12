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
    
    @available(OSX 10.11, *)
    func addLayoutGuide() -> NSLayoutGuide
    {
        let guide = NSLayoutGuide()
        
        addLayoutGuide(guide)
        
        return guide
    }
    
    @available(OSX 10.11, *)
    func addLayoutGuides(_ number: Int) -> [NSLayoutGuide]
    {
        guard number > 0 else { return [] }
        
        var guides = [NSLayoutGuide]()
        
        for _ in 0 ..< number
        {
            let guide = NSLayoutGuide()
            
            addLayoutGuide(guide)
            
            guides.append(guide)
        }
        
        return guides
    }
}
