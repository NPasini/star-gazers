//
//  JsonEncoder.swift
//  gazersTests
//
//  Created by Nicolò Pasini on 17/03/21.
//

import Quick
import Nimble
import Foundation

class Json {
    let fileName: String

    init(fileName: String) {
        self.fileName = fileName
    }

    func convertToData() -> Data {
        let path = Bundle.init(for: type(of: self)).path(forResource: fileName, ofType: "json") ?? ""
        let data = (try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe))

        guard let dataObject = data else {
            fail("Wrong json file path")
            return Data()
        }

        return dataObject
    }
}

