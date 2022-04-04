//
//  AlbumRequestService.swift
//  Music
//
//  Created by Margarita Slesareva on 30.03.2022.
//

import UIKit

protocol AlbumRequestService {
    func requestAlbums(artistName: String,
        limit: Int,
        offset: Int,
        completion: @escaping (Result<[Album], RequestError>) -> Void
    )
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, RequestError>) -> Void)
}

final class AlbumRequestServiceImpl: AlbumRequestService {
    
    private let networkManager: NetworkManager
    private let albumJsonParser: AlbumJsonParser
    
    init(networkManager: NetworkManager, albumJsonParser: AlbumJsonParser) {
        self.networkManager = networkManager
        self.albumJsonParser = albumJsonParser
    }
    
    func requestAlbums(artistName: String,
        limit: Int,
        offset: Int,
        completion: @escaping (Result<[Album], RequestError>) -> Void
    ) {
        let dataRequest = AlbumRequest(aritstName: artistName, limit: limit, offset: offset)
        
        networkManager.sendRequest(request: dataRequest) { result in
            switch result {
            case .success(let data):
                let albums = self.parseAlbums(data: data)
                completion(.success(albums))
            case .failure:
                completion(.failure(.downloadFail))
            }
        }
    }
    
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, RequestError>) -> Void) {
        let imageUrlRequest = ImageUrlRequest(url: url)
        
        networkManager.sendRequest(request: imageUrlRequest) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        completion(.success(image))
                    }
                case .failure:
                    completion(.failure(.downloadFail))
                }
            }
        }
    }
            
    private func parseAlbums(data: Data) -> [Album] {
        if let albums = albumJsonParser.parseData(data: data) {
            return albums
        }
        
        return []
    }
}
