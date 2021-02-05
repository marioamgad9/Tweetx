//
//  TXFollowerRemoteAPI.swift
//  TXKit
//
//  Created by Mario Mouris on 03/02/2021.
//

import PromiseKit
import Swifter

public class TXFollowerRemoteAPI: FollowersRemoteAPI {
    
    // MARK: - Properties
    private lazy var swifter: Swifter = {
        return Swifter(consumerKey: NetworkConstants.TwitterConstants.consumerKey,
                       consumerSecret: NetworkConstants.TwitterConstants.consumerSecretKey)
    }()
    private let dataStore: UserSessionDataStore
    
    // MARK: - Initializer
    public init(dataStore: UserSessionDataStore) {
        self.dataStore = dataStore
    }
    
    // MARK: - Methods
    public func getFollowers() -> Promise<[TwitterUser]> {
        return Promise<[TwitterUser]> { seal in
            // Get user ID
            dataStore.getUserID().done { userId in
                // Fetch followers list from twitter
                self.swifter.getUserFollowers(for: .id(userId), success: { (json, next, prev) in
                    guard let followersJSON = json.array else {
                        seal.reject(TXKitError.notFound)
                        return
                    }
                    
                    var followers: [TwitterUser] = []
                    for followerJSON in followersJSON {
                        followers.append(TwitterUser(from: followerJSON))
                    }
                    seal.fulfill(followers)
                }, failure: { (error) in
                    seal.reject(TXKitError.unknown)
                })
            }.catch { _ in
                seal.reject(TXKitError.noUserIDFound)
            }
        }
    }
    
    public func getTweetsForFollower(followerId: String) -> Promise<[Tweet]> {
        return Promise<[Tweet]> { seal in
            self.swifter.getTimeline(for: .id(followerId), count: 10, includeRetweets: false, success: { (json) in
                guard let tweetsJSON = json.array else {
                    seal.reject(TXKitError.notFound)
                    return
                }
                
                var tweets: [Tweet] = []
                for tweetJSON in tweetsJSON {
                    tweets.append(Tweet(from: tweetJSON))
                }
                seal.fulfill(tweets)
            }, failure: { (error) in
                seal.reject(TXKitError.unknown)
            })
        }
    }
}
