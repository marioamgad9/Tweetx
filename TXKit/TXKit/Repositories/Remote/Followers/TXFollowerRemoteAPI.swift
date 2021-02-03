//
//  TXFollowerRemoteAPI.swift
//  TXKit
//
//  Created by Mario Mouris on 03/02/2021.
//

import Alamofire
import PromiseKit

public class TXFollowerRemoteAPI: FollowersRemoteAPI {
    
    // MARK: - Initializer
    public init() {}
    
    // MARK: - Methods
    // TODO: - Mocked, provide real implementation
    public func getFollowers() -> Promise<[TwitterUser]> {
        return Promise<[TwitterUser]> { seal in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let mockedValues: [TwitterUser] = [
                    TwitterUser(id: 0, name: "Marco Polo", twitterHandle: "@marco_polo", bio: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s", profilePicture: "https://i.pinimg.com/originals/80/e3/86/80e3869ea24b00b264ff0b075d1e9384.jpg"),
                    TwitterUser(id: 0, name: "Santa Open", twitterHandle: "@santa_baby", bio: nil, profilePicture: "https://www.sabrillu.com/wp-content/uploads/2019/10/Weronika-vorschau.jpg"),
                    TwitterUser(id: 0, name: "Loriel Iposion", twitterHandle: "@non_sense", bio: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", profilePicture: nil)
                ]
                seal.fulfill(mockedValues)
            }
        }
    }
    
    public func getTweetsForFollower(followerId: Int) -> Promise<[Tweet]> {
        return Promise<[Tweet]> { seal in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let mockedValues = [
                    Tweet(id: 0, content: "This is a tweet I wrote", time: Date(), userId: 1),
                    Tweet(id: 1, content: "Gismo bimbo. Another tweet by the same user. This is a tweet I wrote", time: Date(), userId: 1),
                    Tweet(id: 1, content: "Hey there", time: Date(), userId: 1),
                    Tweet(id: 1, content: "Another tweet by the same user. This is a tweet I wrote", time: Date(), userId: 1),
                ]
                seal.fulfill(mockedValues)
            }
        }
    }
}
