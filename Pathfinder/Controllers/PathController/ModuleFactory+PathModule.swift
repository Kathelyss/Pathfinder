extension ModuleFactory {

    func createPathModule(title: String, graph: [GraphNode], items: [GraphNode]) -> PathModule {
        let viewModel = PathViewModel(title: title, graph: graph, items: items)
        return PathViewController(viewModel: viewModel)
    }
}
