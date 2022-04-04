//
//  AlbumJsonParser.swift
//  Music
//
//  Created by Margarita Slesareva on 30.03.2022.
//

import UIKit

final class AlbumJsonParser: Parser {
        
    func parseData(data: Data) -> [Album]? {
        var albums = [Album]()
        
        if let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            guard let jsonDicts = jsonObject["results"] as? [[String: Any]] else {
                return nil
            }
            
            for json in jsonDicts {
                
                guard
                    let albumId = json["collectionId"] as? Int,
                    let imageUrlString = json["artworkUrl100"] as? String,
                    let imageUrl = URL(string: imageUrlString)
                else {
                    return nil
                }
                
                let albumName = json["collectionName"] as? String
                let performer = json["artistName"] as? String

                let album = Album(
                    id: albumId,
                    imageUrl: imageUrl,
                    name: albumName,
                    artist: performer
                )
                
                albums.append(album)
            }
        }
        
        return albums
    }
}
