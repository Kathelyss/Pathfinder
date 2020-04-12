import UIKit

/// Placeholder view visual attributes without layout.
open class BasePlaceholderViewModel {

    /// Title text with text attributes.
    public let title: ViewText
    /// Description text with text attributes.
    public let description: ViewText?
    /// Center image of placeholder.
    public let centerImage: UIImage?
    /// Button title with text attributes.
    public let buttonTitle: ViewText?

    /// Memberwise initializer.
    ///
    /// - Parameters:
    ///   - title: Title text with text attributes.
    ///   - description: Description text with text attributes.
    ///   - centerImage: Center image of placeholder.
    ///   - buttonTitle: Button title with text attributes.
    ///   - background: Placeholder background.
    public init(title: ViewText,
                description: ViewText? = nil,
                centerImage: UIImage? = nil,
                buttonTitle: ViewText? = nil) {

        self.title = title
        self.description = description
        self.centerImage = centerImage
        self.buttonTitle = buttonTitle
    }
}

public extension BasePlaceholderViewModel {

    /// Returns true if description is not nil.
    var hasDescription: Bool {
        return description != nil
    }

    /// Returns true if buttonTitle is not nil.
    var hasButton: Bool {
        return buttonTitle != nil
    }

    /// Returns true if centerImage is not nil.
    var hasCenterImage: Bool {
        return centerImage != nil
    }
}
