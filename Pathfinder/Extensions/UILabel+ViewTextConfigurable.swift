import UIKit

extension UILabel: ViewTextConfigurable {

    public var textFont: UIFont? {
        get {
            return font
        }
        set {
            font = newValue
        }
    }

    public var titleColor: UIColor? {
        get {
            return textColor
        }
        set {
            textColor = newValue
        }
    }
}
