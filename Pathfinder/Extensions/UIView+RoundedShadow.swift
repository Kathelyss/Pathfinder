import UIKit

extension UIView {

    func addRoundedShadow(shadowColor: UIColor = .gray,
                          shadowOpacity: Float = 0.2,
                          shadowOffset: CGSize = CGSize(width: 0, height: Constants.smallInset),
                          shadowRadius: CGFloat = 2) {

        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}
