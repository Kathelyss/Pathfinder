import UIKit

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
