//
//  SongRequestService.swift
//  Music
//
//  Created by Margarita Slesareva on 04.04.2022.
//

import Foundation
import UIKit

protocol SongRequestService {
    func requestSongs(albumId: Int, completion: @escaping (Result<[Song], RequestError>) -> Void)
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, RequestError>) -> Void)
}

final class SongRequestServiceImpl: SongRequestService {
        
    private let networkManager: NetworkManager
    private let songJsonParser: SongJsonParser
    
    init(networkManager: NetworkManager, songJsonParser: SongJsonParser) {
        self.networkManager = networkManager
        self.songJsonParser = songJsonParser
    }
    
    func requestSongs(albumId: Int, completion: @escaping (Result<[Song], RequestError>) -> Void) {
        let dataRequest = SongRequest(albumId: albumId)
        
        networkManager.sendRequest(request: dataRequest) { result in
            switch result {
            case .success(let data):
                let songs = self.parseSongs(data: data)
                completion(.success(songs))
            case .failure:
                completion(.failure(.downloadFail))
            }
        }
    }
    
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, RequestError>) -> Void) {
        let modifiedLastPath = "500x500bb.jpg"
        let urlWithoutLastPath = url.deletingLastPathComponent()
        
        let imageUrlRequest = ImageUrlRequest(url: urlWithoutLastPath.appendingPathComponent(modifiedLastPath))
        
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
    
    private func parseSongs(data: Data) -> [Song] {
        if let songs = songJsonParser.parseData(data: data) {
            return songs
        }
        
        return []
    }
}
