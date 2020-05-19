import UIKit

extension UIAlertController {

    static func  successfullResultActionSheet(_ clearHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)

        let titleFont = [NSAttributedString.Key.font: UIFont.monospacedSystemFont(ofSize: 16, weight: .bold)]
        let messageFont = [NSAttributedString.Key.font: UIFont.monospacedSystemFont(ofSize: 14, weight: .medium)]

        let titleAttrString = NSMutableAttributedString(string: "Корзина собрана", attributes: titleFont)
        let messageAttrString = NSMutableAttributedString(string: "Комплектация товара завершена.\n\nОчистить маршрут?",
                                                          attributes: messageFont)

        alert.setValue(titleAttrString, forKey: "attributedTitle")
        alert.setValue(messageAttrString, forKey: "attributedMessage")

        alert.addAction(UIAlertAction(title: "Очистить", style: .default, handler: clearHandler))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))

        return alert
    }

    static func errorAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Oшибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
        return alert
    }
}
