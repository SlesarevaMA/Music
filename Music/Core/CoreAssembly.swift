//
//  CoreAssembly.swift
//  Music
//
//  Created by Margarita Slesareva on 31.03.2022.
//

final class CoreAssembly {
    static let networkManager: NetworkManager = NetworkManagerImpl()
    static let albumJsonParser = AlbumJsonParser()
    static let songJsonParser = SongJsonParser()
}
