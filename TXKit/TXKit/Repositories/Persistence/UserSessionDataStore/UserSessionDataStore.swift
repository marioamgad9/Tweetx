//
//  UserSessionDataStore.swift
//  TXKit
//
//  Created by Mario Mouris on 04/02/2021.
//

import PromiseKit

/// Handles storing the auth tokens in the device to be retrieved later
public protocol UserSessionDataStore {
    func getUserID() -> Promise<String>
    func save(userID: String) -> Promise<String>
    func deleteUserID() -> Promise<()>
}
