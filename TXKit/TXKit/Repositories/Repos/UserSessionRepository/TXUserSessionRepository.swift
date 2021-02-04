//
//  TXUserSessionRepository.swift
//  TXKit
//
//  Created by Mario Mouris on 04/02/2021.
//

import PromiseKit
import Common

public class TXUserSessionRepository: NSObject, UserSessionRepository {
    
    // MARK: - Properties
    private let dataStore: UserSessionDataStore
    private let remoteAPI: AuthRemoteAPI
    
    // MARK: - Initializer
    public init(dataStore: UserSessionDataStore, remoteAPI: AuthRemoteAPI) {
        self.dataStore = dataStore
        self.remoteAPI = remoteAPI
    }
    
    // MARK: - Methods
    public func getUserID() -> Promise<String> {
        return dataStore.getUserID()
    }
    
    public func signInWithTwitter(viewController: UIViewController) -> Promise<String> {
        return Promise<String> { seal in
            self.remoteAPI.signInWithTwitter(viewController: viewController).done { userID in
                self.dataStore.save(userID: userID).done { savedUserID in
                    seal.fulfill(savedUserID)
                }.catch { seal.reject($0) }
            }.catch { seal.reject($0) }
        }
    }
    
    public func signOut() -> Promise<()> {
        return dataStore.deleteUserID()
    }
}
