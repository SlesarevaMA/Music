//
//  AlbumCell.swift
//  Music
//
//  Created by Margarita Slesareva on 29.03.2022.
//

import UIKit

private enum Metrics {
    static let sideOfalbumImageView: CGFloat = 90
    static let cellSpacing: CGFloat = 8
}

final class AlbumCell: UITableViewCell {
    let albumImageView = UIImageView()
    private let albumNameLabel = UILabel()
    private let performerLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle , reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        albumNameLabel.font = .systemFont(ofSize: 19, weight: .medium)
        albumNameLabel.numberOfLines = 2
        
        performerLabel.font = .systemFont(ofSize: 16, weight: .regular)
        performerLabel.numberOfLines = 2
        
        albumImageView.layer.cornerRadius = 8
        albumImageView.clipsToBounds = true
        
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        performerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(albumImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(performerLabel)
 
        // Констрейнт UIView-Encapsulated-Layout-Height выставляется на 0.5 больше, чем ожидаемая высота,
        // что ломает heightConstraint, поэтому приходится понизить ее приоритет.
        let heightConstraint = albumImageView.heightAnchor.constraint(equalToConstant: Metrics.sideOfalbumImageView)
        heightConstraint.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            heightConstraint,
            albumImageView.widthAnchor.constraint(equalTo: albumImageView.heightAnchor),

            albumImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Metrics.cellSpacing
            ),
            albumImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.cellSpacing
            ),
            albumImageView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Metrics.cellSpacing
            ),
            
            albumNameLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Metrics.cellSpacing
            ),
            albumNameLabel.leadingAnchor.constraint(
                equalTo: albumImageView.trailingAnchor,
                constant: Metrics.cellSpacing
            ),
            albumNameLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Metrics.cellSpacing
            ),
            
            performerLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor),
            performerLabel.leadingAnchor.constraint(equalTo: albumNameLabel.leadingAnchor),
            performerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Album) {
        albumNameLabel.text = model.name
        performerLabel.text = model.artist
    }
    
    func displayImage(image: UIImage?) {
        albumImageView.image = image
    }
}
