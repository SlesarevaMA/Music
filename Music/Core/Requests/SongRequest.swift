//
//  SongRequest.swift
//  Music
//
//  Created by Margarita Slesareva on 04.04.2022.
//

import Foundation

struct SongRequest: Request {
    
    private var albumId: Int

    init(albumId: Int) {
        self.albumId = albumId
    }

    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: RequestConstants.globalUrl + "/lookup")

        urlComponents?.queryItems = [
            URLQueryItem(name: "id", value: String(albumId)),
            URLQueryItem(name: "entity", value: "song")
        ]
                
        guard let url = urlComponents?.url else {
            fatalError("Unable to create url")
        }
        
        return URLRequest(url: url)
    }
}
