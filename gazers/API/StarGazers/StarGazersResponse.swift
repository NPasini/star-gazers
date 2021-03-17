//
//  StarGazersResponse.swift
//  gazers
//
//  Created by Nicolò Pasini on 16/03/21.
//

import OSLogger
import Foundation
import NetworkManager

struct StarGazersResponse {
    let gazers: [Gazer]
}

extension StarGazersResponse: CustomDecodable {
    static func decode(_ data: Data) -> CustomDecodable? {
        let gazers = try? JSONDecoder().decode([Gazer].self, from: data)

        if let gazersList = gazers {
            OSLogger.networkLog(message: "Star Gazers Response contains \(gazersList.count) objects", access: .public, type: .debug)
            return StarGazersResponse(gazers: gazersList)
        } else {
            OSLogger.networkLog(message: "Decoding of Star Gazers Response was not successful", access: .public, type: .debug)
            return nil
        }
    }
}

