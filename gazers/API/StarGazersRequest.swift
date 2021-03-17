//
//  StarGazersRequest.swift
//  gazers
//
//  Created by Nicolò Pasini on 16/03/21.
//

import OSLogger
import Foundation
import NetworkManager

class StarGazersRequest: GetRequest<StarGazersResponse> {
    private let perPageItems: Int = 15

    init(repositoryName: String, owner: String, page: Int) {
        let host = "api.github.com"
        let path = "repos/\(owner)/\(repositoryName)/stargazers"

        let queryParameters: [String : CustomStringConvertible] = ["per_page": perPageItems, "page": page]

        super.init(host: host, path: path, queryParameters: queryParameters)
    }

    override func validateResponse(_ response: URLResponse) -> NSError? {
        guard let httpResponse = response as? HTTPURLResponse else {
            OSLogger.networkLog(message: "Received invalid response", access: .public, type: .debug)
            return GazerError(networkError: .invalidResponse)
        }

        switch httpResponse.statusCode {
        case 200...399:
            return nil
        default:
            OSLogger.networkLog(message: "Received HTTP Response with Error code \(httpResponse.statusCode)", access: .public, type: .debug)
            return GazerError(networkError: .invalidResponse)
        }
    }
}

