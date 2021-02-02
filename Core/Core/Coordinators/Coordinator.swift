import UIKit

public typealias CoordinatorStartCompletionHandler = () -> ()
public typealias CoordinatorFinishCompletionHandler = () -> ()

/**
 A coordinator is responsible for navigation between views.
 No view should be able to navigate on its own, that's a responsibility for its coordinator.
 It should have a start and a finish, each with an optional completion handler.
 */
protocol Coordinator {
    /// Starts the coordinator flow
    func start(completionHandler: CoordinatorStartCompletionHandler?)
    
    /// Finishes the coordinator flow
    func finish(completionHandler: CoordinatorStartCompletionHandler?)
}
