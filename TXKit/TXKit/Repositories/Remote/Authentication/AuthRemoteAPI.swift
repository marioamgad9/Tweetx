//
//  AuthRemoteAPI.swift
//  TXKit
//
//  Created by Mario Mouris on 04/02/2021.
//

import Foundation
import PromiseKit

/// Handles authenticating the user
public protocol AuthRemoteAPI {
    func signInWithTwitter(viewController: UIViewController) -> Promise<String>
}
