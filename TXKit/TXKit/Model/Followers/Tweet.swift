//
//  Tweet.swift
//  TXKit
//
//  Created by Mario Mouris on 03/02/2021.
//

import Foundation

public struct Tweet: Codable {
    public let id: Int
    public let content: String
    public let time: Date
    public let user: TwitterUser
}
