import UIKit

extension UIButton: ViewTextConfigurable {

    public var textFont: UIFont? {
        get {
            return titleLabel?.font
        }
        set {
            titleLabel?.font = newValue
        }
    }

    public var titleColor: UIColor? {
        get {
            return currentTitleColor
        }
        set {
            setTitleColor(newValue, for: [])
        }
    }

    public var textAlignment: NSTextAlignment {
        get {
            return contentHorizontalAlignment.textAlignment
        }
        set {
            contentHorizontalAlignment = .init(textAlignment: newValue)
        }
    }

    public var text: String? {
        get {
            return currentTitle
        }
        set {
            setTitle(newValue, for: [])
        }
    }

    public var attributedText: NSAttributedString? {
        get {
            return currentAttributedTitle
        }
        set {
            setAttributedTitle(newValue, for: [])
        }
    }
}

private extension UIControl.ContentHorizontalAlignment {

    init(textAlignment: NSTextAlignment) {
        switch textAlignment {
        case .left:
            if #available(iOS 11, tvOS 11, *) {
                self = .leading
            } else {
                self = .left
            }

        case .right:
            if #available(iOS 11, tvOS 11, *) {
                self = .trailing
            } else {
                self = .right
            }

        case .center:
            self = .center

        case .justified:
            self = .fill

        case .natural:
            if #available(iOS 11, tvOS 11, *) {
                self = .leading
            } else {
                self = .left
            }
        }
    }

    var textAlignment: NSTextAlignment {
        switch self {
        case .left:
            return .left

        case .right:
            return .right

        case .center:
            return .center

        case .fill:
            return .justified

        case .leading:
            return .natural

        case .trailing:
            return .right
        }
    }
}
