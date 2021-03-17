//
//  Gazer.swift
//  gazers
//
//  Created by Nicolò Pasini on 16/03/21.
//

import Foundation

struct Gazer: Decodable {
    enum CodingKeys: CodingKey {
        case login
        case avatar_url
    }

    let name: String
    let avatarUrl :String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .login)
        avatarUrl = try container.decode(String.self, forKey: .avatar_url)
    }
}
