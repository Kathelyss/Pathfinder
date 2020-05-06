extension ModuleFactory {

    func createPathModule(title: String) -> PathModule {
        let viewModel = PathViewModel(title: title)
        return PathViewController(viewModel: viewModel)
    }
}
