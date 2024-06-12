import Foundation
import UIKit

class ColorManager {
    
    class func getColor(taskStatus: TaskStatus) -> UIColor {
        switch taskStatus {
        case .unresolved:
            return UIColor.textUnresolved
        case .resolved:
            return UIColor.textResolved
        case .undefined:
            return UIColor.primaryTheme
        }
    }
}
