extension ModuleFactory {

    func createPathModule(title: String, graph: [Node], items: [Node]) -> PathModule {
        let viewModel = PathViewModel(title: title, graph: graph, items: items)
        return PathViewController(viewModel: viewModel)
    }
}
