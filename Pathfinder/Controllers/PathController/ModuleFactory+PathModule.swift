extension ModuleFactory {

    func createPathModule() -> PathModule {
        let viewModel = PathViewModel()
        return PathViewController(viewModel: viewModel)
    }
}
