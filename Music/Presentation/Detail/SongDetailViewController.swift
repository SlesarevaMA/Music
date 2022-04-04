//
//  SongDetailViewController.swift
//  Music
//
//  Created by Margarita Slesareva on 30.03.2022.
//

import UIKit

private enum Metrics {
    static let horizontalSpacing: CGFloat = 12
    static let verticalSpacing: CGFloat = 16
}

final class SongDetailViewController: UIViewController {
    
    private let songRequestService: SongRequestService
    
    private let albumImageView = UIImageView()
    private let albumNameLabel = UILabel()
    private let artistLabel = UILabel()
    private let songsTableView = UITableView()
    
    private var albumId: Int?
    private var albumImageUrl: URL?
    private var songs = [Song]()
    
    init(songRequestService: SongRequestService) {
        self.songRequestService = songRequestService
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        
        songsTableView.delegate = self
        songsTableView.dataSource = self
        songsTableView.register(SongCell.self, forCellReuseIdentifier: "SongCell")
        songsTableView.estimatedRowHeight = 30
        songsTableView.rowHeight = UITableView.automaticDimension
        
        view.addSubview(albumImageView)
        view.addSubview(albumNameLabel)
        view.addSubview(artistLabel)
        view.addSubview(songsTableView)
        
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        songsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            albumImageView.widthAnchor.constraint(
                equalTo: albumImageView.heightAnchor
            ),
            albumImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Metrics.verticalSpacing
            ),
            albumImageView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: Metrics.horizontalSpacing
            ),
            albumImageView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -Metrics.horizontalSpacing
            ),
            
            artistLabel.topAnchor.constraint(
                equalTo: albumImageView.bottomAnchor,
                constant:  Metrics.verticalSpacing
            ),
            artistLabel.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: Metrics.horizontalSpacing
            ),
            albumNameLabel.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: Metrics.horizontalSpacing
            ),
            
            albumNameLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor),
            albumNameLabel.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: Metrics.horizontalSpacing
            ),
            albumNameLabel.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: Metrics.horizontalSpacing
            ),
            
            songsTableView.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor),
            songsTableView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: Metrics.horizontalSpacing
            ),
            songsTableView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -Metrics.horizontalSpacing
            ),
            songsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),            
        ])
        
        if let albumId = albumId {
            songRequestService.requestSongs(albumId: albumId) { result in
                switch result {
                case .success(let songs):
                    DispatchQueue.main.async {
                        self.songs = songs
                        self.songsTableView.reloadData()
                    }
                case .failure:
                    break
                }
            }
        }
        
        if let albumImageUrl = albumImageUrl {
            songRequestService.downloadImage(from: albumImageUrl) { result in
                if case .success(let image) = result {
                    DispatchQueue.main.async {
                        self.albumImageView.image = image
                    }
                }
            }
        }
    }
    
    func configure(with album: Album) {
        albumNameLabel.text = album.name
        artistLabel.text = album.artist
        albumId = album.id
        albumImageUrl = album.imageUrl
    }
}

extension SongDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = songsTableView.dequeueReusableCell(
            withIdentifier: "SongCell",
            for: indexPath
        ) as? SongCell else {
            fatalError("Unable to dequeue SongCell")
        }
        
        let song = songs[indexPath.row]
        cell.configure(with: song)
        
        return cell
    }
}
