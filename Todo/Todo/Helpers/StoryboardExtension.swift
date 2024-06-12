import Foundation
import UIKit

extension UIViewController {
    
    class func instantiate<T: UIViewController>() -> T? {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as? T
    }
}
