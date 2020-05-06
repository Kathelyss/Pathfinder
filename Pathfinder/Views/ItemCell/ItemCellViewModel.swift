struct ItemCellViewModel {
    let title: String
    let subtitle: String
    let isIconHidden: Bool
}

extension ItemCellViewModel {
    static let mockCellData = ItemCellViewModel(title: "1. Название товара",
                                                subtitle: "Локация товара - стеллаж 3, позиция 6, полка 4",
                                                isIconHidden: false)
    static let mockCellDataArrowless = ItemCellViewModel(title: "Название товара",
                                                         subtitle: "Локация товара - стеллаж 3, позиция 6, полка 4",
                                                         isIconHidden: true)
}
