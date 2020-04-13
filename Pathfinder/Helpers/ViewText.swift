import UIKit

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
