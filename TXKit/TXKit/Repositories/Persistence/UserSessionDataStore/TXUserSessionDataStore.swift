//
//  TXUserSessionDataStore.swift
//  TXKit
//
//  Created by Mario Mouris on 04/02/2021.
//

import PromiseKit
import KeychainAccess

public class TXUserSessionDataStore: UserSessionDataStore {
    
    // MARK: - Properties
    private let keychain: Keychain

    // MARK: - Initializer
    public init() {
        keychain = Keychain(service: "me.mariomouris.Tweetx")
    }

    // MARK: - Methods
    public func getUserID() -> Promise<String> {
        return Promise() { seal in
            guard let userID = try? keychain.get(KeychainKeys.userID.rawValue) else {
                seal.reject(TXKitError.noUserIDFound)
                return
            }

            seal.fulfill(userID)
        }
    }
    
    public func save(userID: String) -> Promise<String> {
        return Promise() { seal in
            guard (try? keychain.set(userID, key: KeychainKeys.userID.rawValue)) != nil else {
                seal.reject(TXKitError.keychainError)
                return
            }

            seal.fulfill(userID)
        }
    }
    
    public func deleteUserID() -> Promise<()> {
        return Promise<()> { seal in
            guard (try? keychain.remove(KeychainKeys.userID.rawValue)) != nil else {
                seal.reject(TXKitError.keychainError)
                return
            }
            
            seal.fulfill(())
        }
    }
}

private enum KeychainKeys: String {
    case userID = "userID"
}

