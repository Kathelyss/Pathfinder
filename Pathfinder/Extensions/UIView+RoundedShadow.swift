import UIKit

extension UIView {

    func addRoundedShadow(shadowColor: UIColor = .systemTeal,
                          shadowOpacity: Float = 0.2,
                          shadowOffset: CGSize = CGSize(width: 0, height: Constants.tinyInset),
                          shadowRadius: CGFloat = Constants.defaultInset) {

        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}
