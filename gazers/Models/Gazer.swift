//
//  Gazer.swift
//  gazers
//
//  Created by Nicolò Pasini on 16/03/21.
//

import Foundation

struct Gazer: Decodable {
    enum CodingKeys: CodingKey {
        case id
        case login
        case avatar_url
    }

    let id: Int
    let name: String?
    let avatarUrl: String?

    init(id: Int, name: String?, avatarUrl: String?) {
        self.id = id
        self.name = name
        self.avatarUrl = avatarUrl
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .login)
        avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatar_url)
    }
}

extension Gazer: Equatable {
    static func ==(lhs: Gazer, rhs: Gazer) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.avatarUrl == rhs.avatarUrl
    }
}
