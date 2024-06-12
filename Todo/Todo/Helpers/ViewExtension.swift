import Foundation
import UIKit

@IBDesignable
class DesignableView: UIView {
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = (newValue > 0)
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
        }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    func applyShadow(cornerRadius: CGFloat, width: CGFloat, height: CGFloat, radius: CGFloat, opacity: Float) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        //        layer.shadowColor = UIColor.red.cgColor
        layer.shadowColor = UIColor(named: "Shadow Black")?.cgColor
        layer.shadowOffset = CGSize(width: width, height: height)
    }
}


extension UIView {
    
    class func fromNib(named: String? = nil) -> Self {
        let name = named ?? "\(Self.self)"
        guard
            let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        else { fatalError("missing expected nib named: \(name)") }
        guard
            let view = nib.first as? Self
        else { fatalError("view of type \(Self.self) not found in \(nib)") }
        return view
    }
    
    func loadView() -> UIView {
        let bundleName = Bundle(for: type(of: self))
        let nibName = String(describing: type(of: self))
        let nib = UINib (nibName: nibName, bundle: bundleName)
        let view = nib.instantiate (withOwner: nil, options: nil).first as!
        UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

