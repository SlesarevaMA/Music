//
//  RequestError.swift
//  Music
//
//  Created by Margarita Slesareva on 30.03.2022.
//

import Foundation

enum RequestError: Error {
    case downloadFail
    case parseFail
    
    var title: String {
        switch self {
        case .parseFail:
            return "Parse fail"
        case .downloadFail:
            return "Download fail"
        }
    }

}
