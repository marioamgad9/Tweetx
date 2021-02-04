//
//  UserSessionRepository.swift
//  TXKit
//
//  Created by Mario Mouris on 04/02/2021.
//

import Foundation
import PromiseKit

/// Handles the user session through coordination between the local datastore and the authentication API
public protocol UserSessionRepository {
    func getUserID() -> Promise<String>
    func signInWithTwitter(viewController: UIViewController) -> Promise<String>
}
