//
//  SignedInResponder.swift
//  TXKit
//
//  Created by Mario Mouris on 03/02/2021.
//

import Foundation

/// A way to communicate between the repository and the views that the user is now signed in
public protocol SignedInResponder {
    func signedIn(with userID: String)
}
