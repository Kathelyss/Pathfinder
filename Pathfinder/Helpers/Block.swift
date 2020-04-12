import Foundation

/// Closure with custom arguments and return value.
public typealias Closure<Input, Output> = (Input) -> Output

/// Closure with no arguments and custom return value.
public typealias ResultClosure<Output> = () -> Output

/// Closure that takes custom arguments and returns Void.
public typealias ParameterClosure<Input> = Closure<Input, Void>

/// Closure that takes no arguments and returns Void.
public typealias VoidBlock = ResultClosure<Void>
