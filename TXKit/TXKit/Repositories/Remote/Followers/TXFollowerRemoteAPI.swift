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
                    TwitterUser(id: 0, name: "Marco Polo", twitterHandle: "@marco_polo", bio: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s", profilePicture: "https://i.pinimg.com/originals/80/e3/86/80e3869ea24b00b264ff0b075d1e9384.jpg", backgroundImage: "https://images.squarespace-cdn.com/content/v1/52afda83e4b0cb06a5950857/1531755377169-2CEKOEZRT7K6I1QSGVRM/ke17ZwdGBToddI8pDm48kPTrHXgsMrSIMwe6YW3w1AZ7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z4YTzHvnKhyp6Da-NYroOW3ZGjoBKy3azqku80C789l0p52bY8kZn6Mpkp9xtPUVLhvLurswpbKwwoDWqBh58NLxQZMhB36LmtxTXHHtLwR3w/elias-stein-fansided-nba-twitter-pattern.png"),
                    TwitterUser(id: 0, name: "Santa Open", twitterHandle: "@santa_baby", bio: nil, profilePicture: "https://www.sabrillu.com/wp-content/uploads/2019/10/Weronika-vorschau.jpg", backgroundImage: "https://s3.amazonaws.com/ceblog/wp-content/uploads/2016/08/05114542/twitter-followers.png"),
                    TwitterUser(id: 0, name: "Loriel Iposion", twitterHandle: "@non_sense", bio: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", profilePicture: nil, backgroundImage: nil)
                ]
                seal.fulfill(mockedValues)
            }
        }
    }
    
    public func getTweetsForFollower(followerId: Int) -> Promise<[Tweet]> {
        return Promise<[Tweet]> { seal in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let mockedValues = [
                    Tweet(id: 0, content: "This is a tweet I wrote", time: Date(), user: TwitterUser(id: 0, name: "Santa Open", twitterHandle: "@santa_baby", bio: nil, profilePicture: "https://www.sabrillu.com/wp-content/uploads/2019/10/Weronika-vorschau.jpg", backgroundImage: "https://s3.amazonaws.com/ceblog/wp-content/uploads/2016/08/05114542/twitter-followers.png")),
                    Tweet(id: 1, content: "Gismo bimbo. Another tweet by the same user. This is a tweet I wrote", time: Date(), user: TwitterUser(id: 0, name: "Santa Open", twitterHandle: "@santa_baby", bio: nil, profilePicture: "https://www.sabrillu.com/wp-content/uploads/2019/10/Weronika-vorschau.jpg", backgroundImage: "https://s3.amazonaws.com/ceblog/wp-content/uploads/2016/08/05114542/twitter-followers.png")),
                    Tweet(id: 1, content: "Hey there", time: Date(), user: TwitterUser(id: 0, name: "Santa Open", twitterHandle: "@santa_baby", bio: nil, profilePicture: "https://www.sabrillu.com/wp-content/uploads/2019/10/Weronika-vorschau.jpg", backgroundImage: "https://s3.amazonaws.com/ceblog/wp-content/uploads/2016/08/05114542/twitter-followers.png")),
                    Tweet(id: 1, content: "Another tweet by the same user. This is a tweet I wrote", time: Date(), user: TwitterUser(id: 0, name: "Santa Open", twitterHandle: "@santa_baby", bio: nil, profilePicture: "https://www.sabrillu.com/wp-content/uploads/2019/10/Weronika-vorschau.jpg", backgroundImage: "https://s3.amazonaws.com/ceblog/wp-content/uploads/2016/08/05114542/twitter-followers.png")),
                    Tweet(id: 1, content: "Another tweet by the same user. This is a tweet I wrote", time: Date(), user: TwitterUser(id: 0, name: "Santa Open", twitterHandle: "@santa_baby", bio: nil, profilePicture: "https://www.sabrillu.com/wp-content/uploads/2019/10/Weronika-vorschau.jpg", backgroundImage: "https://s3.amazonaws.com/ceblog/wp-content/uploads/2016/08/05114542/twitter-followers.png")),
                    Tweet(id: 1, content: "Another tweet by the same user. This is a tweet I wrote", time: Date(), user: TwitterUser(id: 0, name: "Santa Open", twitterHandle: "@santa_baby", bio: nil, profilePicture: "https://www.sabrillu.com/wp-content/uploads/2019/10/Weronika-vorschau.jpg", backgroundImage: "https://s3.amazonaws.com/ceblog/wp-content/uploads/2016/08/05114542/twitter-followers.png")),
                    Tweet(id: 1, content: "Another tweet by the same user. This is a tweet I wrote", time: Date(), user: TwitterUser(id: 0, name: "Santa Open", twitterHandle: "@santa_baby", bio: nil, profilePicture: "https://www.sabrillu.com/wp-content/uploads/2019/10/Weronika-vorschau.jpg", backgroundImage: "https://s3.amazonaws.com/ceblog/wp-content/uploads/2016/08/05114542/twitter-followers.png")),
                ]
                seal.fulfill(mockedValues)
            }
        }
    }
}
