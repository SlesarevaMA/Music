//
//  SongCell.swift
//  Music
//
//  Created by Margarita Slesareva on 29.03.2022.
//

import UIKit


private enum Metrics {
    static let sideOfalbumImageView: CGFloat = 96
    static let cellSpasing: CGFloat = 8
}

final class SongCell: UITableViewCell {
    private let albumImageView = UIImageView()
    private let songNameLabel = UILabel()
    private let performerLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle , reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(albumImageView)
        contentView.addSubview(songNameLabel)
        contentView.addSubview(performerLabel)
        
        
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        songNameLabel.translatesAutoresizingMaskIntoConstraints = false
        performerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            albumImageView.widthAnchor.constraint(equalToConstant: Metrics.sideOfalbumImageView),
            albumImageView.heightAnchor.constraint(equalTo: albumImageView.widthAnchor,
                                                   multiplier: 1),
            albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                constant: Metrics.cellSpasing),
            albumImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                   constant: -Metrics.cellSpasing),
            albumImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                    constant: Metrics.cellSpasing),
            albumImageView.trailingAnchor.constraint(equalTo: songNameLabel.leadingAnchor,
                                                     constant: -Metrics.cellSpasing),
            
            songNameLabel.topAnchor.constraint(equalTo: albumImageView.topAnchor,
                                               constant: Metrics.cellSpasing),
            songNameLabel.bottomAnchor.constraint(equalTo: performerLabel.topAnchor,
                                                  constant: Metrics.cellSpasing),
            songNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -Metrics.cellSpasing),
            
            performerLabel.bottomAnchor.constraint(equalTo: albumImageView.bottomAnchor,
                                                   constant: -Metrics.cellSpasing),
            performerLabel.leadingAnchor.constraint(equalTo: songNameLabel.leadingAnchor),
            performerLabel.trailingAnchor.constraint(equalTo: songNameLabel.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
    }
}
