//
//  ServiceAssembly.swift
//  Music
//
//  Created by Margarita Slesareva on 31.03.2022.
//


final class ServiceAssembly {
    static let albumRequestService: AlbumRequestService = AlbumRequestServiceImpl (
        networkManager: CoreAssembly.networkManager,
        albumJsonParser: CoreAssembly.albumJsonParser
    )
    static let songRequestService: SongRequestService = SongRequestServiceImpl (
        networkManager: CoreAssembly.networkManager,
        songJsonParser: CoreAssembly.songJsonParser
    )
}
