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

/// Base set of attributes to configure appearance of text.
open class BaseTextAttributes {

    /// Text font.
    public let font: UIFont
    /// Text color.
    public let color: UIColor
    /// Text alignment.
    public let alignment: NSTextAlignment

    /// Memberwise initializer.
    ///
    /// - Parameters:
    ///   - font: Text font.
    ///   - color: Text color.
    ///   - alignment: Text alignment.
    public init(font: UIFont, color: UIColor, alignment: NSTextAlignment = .natural) {
        self.font = font
        self.color = color
        self.alignment = alignment
    }
}


public extension BaseTextAttributes {

    /// Configures text appearance of given ViewTextConfigurable instance.
    ///
    /// - Parameter view: ViewTextConfigurable instance to configure with BaseTextAttributes.
    func configureBaseApperance(of view: ViewTextConfigurable) {
        view.configureBaseAppearance(with: self)
    }
}

/// Enum that describes text with appearance options.
///
/// - string: Regular string with common and often-used text attributes.
/// - attributedString: Attributed string.
public enum ViewText {

    case string(String, textAttributes: BaseTextAttributes)
    case attributedString(NSAttributedString)
}

public extension ViewText {

    /// Convenient initializer for .string case with default alignment parameter.
    ///
    /// - Parameters:
    ///   - string: Text to use.
    ///   - font: Font to use.
    ///   - color: Color to use.
    ///   - alignment: Alignment to use. Default is natural.
    init(string: String, font: UIFont, color: UIColor, alignment: NSTextAlignment = .natural) {
        self = .string(string, textAttributes: BaseTextAttributes(font: font,
                                                                  color: color,
                                                                  alignment: alignment))
    }

    /// Attributed string created using text attributes.
    var attributedString: NSAttributedString {
        switch self {
        case let .string(title, textAttributes):

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = textAttributes.alignment

            let attributes: [NSAttributedString.Key: Any] = [
                .font: textAttributes.font,
                .foregroundColor: textAttributes.color,
                .paragraphStyle: paragraphStyle
            ]

            return NSAttributedString(string: title, attributes: attributes)

        case .attributedString(let attributedTitle):
            return attributedTitle
        }
    }

    /// Method that calculates size of view text using given max width and height arguments.
    ///
    /// - Parameters:
    ///   - maxWidth: The width constraint to apply when computing the string’s bounding rectangle.
    ///   - maxHeight: The width constraint to apply when computing the string’s bounding rectangle.
    /// - Returns: Returns the size required to draw the text.
    func size(maxWidth: CGFloat = CGFloat.greatestFiniteMagnitude,
              maxHeight: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {

        return attributedString.boundingRect(with: CGSize(width: maxWidth, height: maxHeight),
                                             options: [.usesLineFragmentOrigin, .usesFontLeading],
                                             context: nil).size
    }

    /// Configures given ViewTextConfigurable instance.
    ///
    /// - Parameter view: ViewTextConfigurable instance to configure with ViewText.
    func configure(view: ViewTextConfigurable) {
        view.configure(with: self)
    }
}
