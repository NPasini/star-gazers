//
//  GazerError.swift
//  gazers
//
//  Created by Nicolò Pasini on 16/03/21.
//

import Foundation

private let SPDomain: String = "com.gazer"

class GazerError: NSError {
    convenience init(networkError: NetworkError) {
        self.init(domain: SPDomain, code: networkError.rawValue, userInfo: [NSLocalizedDescriptionKey : String(describing: networkError)])
    }
}
