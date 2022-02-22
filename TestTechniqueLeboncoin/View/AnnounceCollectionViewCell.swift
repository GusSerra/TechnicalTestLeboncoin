//
//  AnnounceCollectionViewCell.swift
//  TestTechniqueLeboncoin
//
//  Created by Gustavo Serra on 21/02/2022.
//

import UIKit

class AnnounceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var announceImageView: UIImageView!
    @IBOutlet weak var announceTitleLabel: UILabel!
    @IBOutlet weak var announcePriceLabel: UILabel!
    @IBOutlet weak var announceCategoryLabel: UILabel!
    @IBOutlet weak var announceUrgencyIndicateur: UIButton!
    
    func configure(_ announceViewModel: AnnounceViewModel) {
        self.announceImageView.image = UIImage(named: "no-image")
        self.announceImageView.loadImage(from: announceViewModel.thumbURL)
        self.announceTitleLabel.text = announceViewModel.title
        self.announcePriceLabel.text = announceViewModel.displayedPrice
        self.announceUrgencyIndicateur.isHidden = announceViewModel.urgency == .urgent ? false : true
    }
}
