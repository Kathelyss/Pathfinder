import UIKit

final class GeneralViewModel {

    var currentWaybillItems: [WaybillItem] = []
    var cellModels: [ItemCellViewModel] = []

    func requestWaybill() {
        // MOCK: replace on api request
        currentWaybillItems = MockEndPoints.items

        currentWaybillItems.forEach {
            let title = "\($0.article.name) - \($0.quantity) штук"
            let subtitle = "Стеллаж \($0.location.rackNumber), позиция \($0.location.position), полка \($0.location.shelfNumber)"
            cellModels.append(ItemCellViewModel(title: title, subtitle: subtitle, isIconHidden: false))
        }
    }
}
