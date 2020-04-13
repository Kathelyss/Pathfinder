import UIKit

/// Protocol that represents text object with appearance attributes.
public protocol ViewTextConfigurable: class {

    /// Font of text object.
    var textFont: UIFont? { get set }

    /// Text color of text object.
    var titleColor: UIColor? { get set }

    /// Text alignment of text object.
    var textAlignment: NSTextAlignment { get set }

    /// Text itself of text object.
    var text: String? { get set }

    /// Attributed text of text object.
    var attributedText: NSAttributedString? { get set }
}

public extension ViewTextConfigurable {

    /// Configures text and text appearance of view using ViewText object.
    ///
    /// - Parameter viewText: ViewText object with text and text appearance.
    func configure(with viewText: ViewText) {
        switch viewText {
        case let .string(text, textAttributes):
            self.text = text
            self.configureBaseAppearance(with: textAttributes)

        case .attributedString(let attributedString):
            self.attributedText = attributedString
        }
    }

    /// Configures text appearance of view.
    ///
    /// - Parameter baseTextAttributes: Set of attributes to configure appearance of text.
    func configureBaseAppearance(with baseTextAttributes: BaseTextAttributes) {
        textFont = baseTextAttributes.font
        titleColor = baseTextAttributes.color
        textAlignment = baseTextAttributes.alignment
    }
}
