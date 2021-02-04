//
//  TXAuthRemoteAPI.swift
//  TXKit
//
//  Created by Mario Mouris on 04/02/2021.
//

import PromiseKit
import Swifter

public class TXAuthRemoteAPI: AuthRemoteAPI {
    
    // MARK: - Properties
    private lazy var swifter: Swifter = {
        return Swifter(consumerKey: NetworkConstants.TwitterConstants.consumerKey,
                       consumerSecret: NetworkConstants.TwitterConstants.consumerSecretKey)
    }()
    
    // MARK: - Initializer
    public init() {}
    
    // MARK: - Methods
    public func signInWithTwitter(viewController: UIViewController) -> Promise<String> {
        return Promise<AccessToken> { seal in
            self.swifter.authorize(withCallback: NetworkConstants.TwitterConstants.callbackURL,
                                   presentingFrom: viewController) { (accessToken, _) in
                guard let userId = accessToken?.userID else {
                    seal.reject(TXKitError.unknown)
                    return
                }
                seal.fulfill(userId)
            } failure: { (error) in
                seal.reject(TXKitError.unknown)
            }
        }
    }
}

