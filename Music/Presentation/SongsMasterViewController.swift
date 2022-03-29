//
//  SongsMasterViewController.swift
//  Music
//
//  Created by Margarita Slesareva on 29.03.2022.
//

import UIKit

final class SongsMasterViewController: UIViewController {
    
    private let songsTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(songsTableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        songsTableView.frame = view.bounds
    }
}

extension SongsMasterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
