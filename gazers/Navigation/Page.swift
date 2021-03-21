//
//  Page.swift
//  gazers
//
//  Created by Nicolò Pasini on 21/03/21.
//

import Foundation

enum Page {
    case starGazerList

    var identifier: String {
        switch self {
        case .starGazerList:
            return "StarGazersListPage"
        }
    }
}
