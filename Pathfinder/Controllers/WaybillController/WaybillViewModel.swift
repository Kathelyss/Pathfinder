import UIKit

final class WaybillViewModel {

    var orderedItems: [WaybillItem] = []
    var cellModels: [ItemCellViewModel] = []

    func getOrderedWaybillItems() {
        // MOCK: add ordering algorithm
        orderedItems = MockEndPoints.items

        orderedItems.enumerated().forEach { (index, item) in
            let title = "\(index + 1). \(item.article.name) - \(item.quantity) штук"
            let subtitle = "Стеллаж \(item.location.rackNumber), позиция \(item.location.position), полка \(item.location.shelfNumber)"
            cellModels.append(ItemCellViewModel(title: title, subtitle: subtitle, isIconHidden: false))
        }
    }
}
