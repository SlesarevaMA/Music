//
//  DataRequest.swift
//  Music
//
//  Created by Margarita Slesareva on 31.03.2022.
//

import Foundation

struct AlbumRequest: Request {
    
    private let aritstName: String
    private let limit: Int
    private let offset: Int

    init(aritstName: String, limit: Int, offset: Int) {
        self.aritstName = aritstName
        self.limit = limit
        self.offset = offset
    }
        
    var urlRequest: URLRequest {

        var urlComponents = URLComponents(string: RequestConstants.globalUrl + "/search")
        urlComponents?.queryItems = [
            URLQueryItem(name: "term", value: aritstName),
            URLQueryItem(name: "media", value: "music"),
            URLQueryItem(name: "entity", value: "album"),
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "offset", value: String(offset))
        ]
                
        guard let url = urlComponents?.url else {
            fatalError("Unable to create url")
        }
        
        return URLRequest(url: url)
    }
}
