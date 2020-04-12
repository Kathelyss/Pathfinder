protocol Coordinatable: class {

    var onFinish: ParameterClosure<Coordinatable>? { get set }

    func start()
}
