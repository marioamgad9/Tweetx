import Foundation

/// Defines how a view model should look like
public protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    var input : Input { get }
    var output : Output { get }
}
