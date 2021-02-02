//
//  NotSignedInResponder.swift
//  TXKit
//
//  Created by Mario Mouris on 03/02/2021.
//

import Foundation

/// A way to communicate between the repository and the views that the user is now not signed in
public protocol NotSignedInResponder {
    func notSignedIn()
}
