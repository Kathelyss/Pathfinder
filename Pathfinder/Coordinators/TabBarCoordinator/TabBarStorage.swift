import Foundation

class TabBarStorage {

    let tabBarModule: TabBarModule

    init(mainStorage: MainStorage, tabBarModule: TabBarModule) {
        self.tabBarModule = tabBarModule
    }
}
