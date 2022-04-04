//
//  Parser.swift
//  Music
//
//  Created by Margarita Slesareva on 31.03.2022.
//

import Foundation

protocol Parser {
    associatedtype Object
    
    func parseData(data: Data) -> Object?
}
