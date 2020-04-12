import Foundation

class TabBarStorage: MainStorage {

    let tabBarModule: TabBarModule

    init(mainStorage: MainStorage, tabBarModule: TabBarModule) {
        self.tabBarModule = tabBarModule
    }
}
