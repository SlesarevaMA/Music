//
//  SongsMasterViewController.swift
//  Music
//
//  Created by Margarita Slesareva on 29.03.2022.
//

import UIKit

private enum Constants {
    static let pageLimit = 10
}

final class SongsMasterViewController: UIViewController {
    
    private let requestService: AlbumRequestService
    private weak var viewControllerFactory: ViewControllerFactory?
    
    private let albumsTableView = UITableView()
    private var albums = [Album]()
    private var imagesCache = NSCache<NSNumber, UIImage>()
    
    private var currentOffset = 0
    private var isNewAlbumsRequested = false
    
    init(requestService: AlbumRequestService, viewControllerFactory: ViewControllerFactory) {
        self.requestService = requestService
        self.viewControllerFactory = viewControllerFactory
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumsTableView.register(AlbumCell.self, forCellReuseIdentifier: "AlbumCell")
        albumsTableView.translatesAutoresizingMaskIntoConstraints = false
        albumsTableView.delegate = self
        albumsTableView.dataSource = self
        albumsTableView.estimatedRowHeight = 100
        albumsTableView.rowHeight = UITableView.automaticDimension
        
        view.addSubview(albumsTableView)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Albums"
        
        requestAlbums()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        albumsTableView.frame = view.bounds
    }
    
    private func requestAlbums() {
        isNewAlbumsRequested = true
        let limit = Constants.pageLimit
        currentOffset += limit
        
        requestService.requestAlbums(artistName: "TheBeatles", limit: limit, offset: currentOffset) { result in
            DispatchQueue.main.async {
                self.processResult(result: result)
                self.isNewAlbumsRequested = false
            }
        }
    }
    
    private func processResult(result: Result<[Album], RequestError>) {
        switch result {
        case .success(let albums):
            self.albums.append(contentsOf: albums)
            albumsTableView.reloadData()
        case .failure(let error):
            handleError(error)
        }
    }
    
    private func handleError(_ error: RequestError) {
        showAlert(title: error.title, message: nil) {
            self.requestAlbums()
        }
    }
    
    private func showAlert(title: String, message: String?, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Try again", style: .default) { _ in
            completion()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension SongsMasterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let songViewController = viewControllerFactory?.getDetailViewcotroller() else {
            return
        }
        
        let album = albums[indexPath.row]
        songViewController.configure(with: album)
        
        showDetailViewController(songViewController, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = albumsTableView.dequeueReusableCell(
            withIdentifier: "AlbumCell",
            for: indexPath
        ) as? AlbumCell else {
            fatalError("Unable to dequeue AlbumCell")
        }
        
        let album = albums[indexPath.row]
        cell.configure(with: album)
        reuseImage(for: cell, with: album.imageUrl, at: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let isLastColumn = indexPath.row == albums.count - 1
        
        guard isLastColumn else {
            return
        }
        
        if !isNewAlbumsRequested {
            requestAlbums()
        }
    }
    
    private func reuseImage(for cell: AlbumCell, with albumUrl: URL, at indexPath: IndexPath) {
        if let image = imagesCache.object(forKey: NSNumber(value: indexPath.row)) {
            cell.displayImage(image: image)
        } else {
            cell.displayImage(image: nil)
            
            requestService.downloadImage (from: albumUrl) { result in
                switch result {
                case .success(let image):
                    self.imagesCache.setObject(image, forKey: NSNumber(value: indexPath.row))
                    cell.displayImage(image: image)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
