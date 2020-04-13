extension ModuleFactory {

    func createGeneralModule() -> GeneralModule {
        let viewModel = GeneralViewModel()
        return GeneralViewController(viewModel: viewModel)
    }
}
