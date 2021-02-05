//
//  Tweet.swift
//  TXKit
//
//  Created by Mario Mouris on 03/02/2021.
//

import Foundation
import Swifter

public struct Tweet {
    
    // MARK: - Properties
    public let id: String
    public let content: String
    public let time: String
    public let user: TwitterUser
    
    // MARK: - Initializer
    init(from json: JSON) {
        self.id = json["id_str"].string ?? ""
        self.content = json["text"].string ?? ""
        self.user = TwitterUser(from: json["user"])
        self.time = json["created_at"].string ?? ""
    }
}
