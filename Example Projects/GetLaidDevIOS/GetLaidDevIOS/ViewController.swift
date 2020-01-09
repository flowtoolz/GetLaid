import PureLayout
import GetLaid
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        let box = view.addForAutoLayout(UIView())
        box.backgroundColor = .blue
        box >> 50
        box >> view.center
        
//        box.autoAlignAxis(.vertical, toSameAxisOf: view)
//        box.autoAlignAxis(.horizontal, toSameAxisOf: view)
    }
}
