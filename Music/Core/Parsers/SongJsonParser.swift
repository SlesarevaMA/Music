//
//  SongJsonParser.swift
//  Music
//
//  Created by Margarita Slesareva on 04.04.2022.
//

import UIKit

final class SongJsonParser: Parser {
        
    func parseData(data: Data) -> [Song]? {
        var songs = [Song]()
        
        if let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            guard let jsonDicts = jsonObject["results"] as? [[String: Any]] else {
                return nil
            }
            
            for json in jsonDicts where (json["wrapperType"] as? String) == "track" && (json["kind"] as? String) == "song" {
                
                let name = json["trackName"] as? String
                 
                if let duration = json["trackTimeMillis"] as? Int {
                    let durationString = stringFromTimeMillis(millis: duration)
                    
                    let song = Song(name: name, duration: durationString)
                    songs.append(song)
                }
            }
        }
        
        return songs
    }
    
    func stringFromTimeMillis(millis: Int) -> String {
        let minutes = millis / 1000 / 60
        let seconds = millis / 100 % 60
        
        return String(format: "%d:%0.2d", minutes, seconds)
    }
}
