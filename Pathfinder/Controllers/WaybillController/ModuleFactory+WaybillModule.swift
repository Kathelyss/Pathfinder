extension ModuleFactory {

    func createWaybillModule() -> WaybillModule {
        let viewModel = WaybillViewModel()
        return WaybillViewController(viewModel: viewModel)
    }
}
