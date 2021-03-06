//
//  SongCell.swift
//  Music
//
//  Created by Margarita Slesareva on 04.04.2022.
//

import UIKit

private enum Metrics {
    static let cellSpacing: CGFloat = 8
}

final class SongCell: UITableViewCell {
    private let songNameLabel = UILabel()
    private let durationLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle , reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        songNameLabel.translatesAutoresizingMaskIntoConstraints = false
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        songNameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        songNameLabel.numberOfLines = 2
        
        contentView.addSubview(songNameLabel)
        contentView.addSubview(durationLabel)
         
        NSLayoutConstraint.activate([
            songNameLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Metrics.cellSpacing
            ),
            songNameLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.cellSpacing
            ),
            songNameLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Metrics.cellSpacing
            ),
            
            durationLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Metrics.cellSpacing
            ),
            durationLabel.leadingAnchor.constraint(
                greaterThanOrEqualTo: songNameLabel.trailingAnchor,
                constant:  Metrics.cellSpacing
            ),
            durationLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Metrics.cellSpacing
            )
        ])
        
        songNameLabel.font = .systemFont(ofSize: 16, weight: .regular)
        durationLabel.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Song) {
        songNameLabel.text = model.name
        durationLabel.text = model.duration
    }
}
