//
//  ImageUrlRequest.swift
//  Music
//
//  Created by Margarita Slesareva on 31.03.2022.
//

import Foundation

struct ImageUrlRequest: Request {
        
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }

    var urlRequest: URLRequest {
        return URLRequest(url: url)
    }
}
