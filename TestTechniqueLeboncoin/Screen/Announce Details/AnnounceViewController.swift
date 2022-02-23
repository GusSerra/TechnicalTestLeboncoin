//
//  AnnounceViewController.swift
//  TestTechniqueLeboncoin
//
//  Created by Gustavo Serra on 23/02/2022.
//

import UIKit

class AnnounceViewController: UITableViewController {
    
    @IBOutlet weak var announceTitleLabel: UILabel!
    @IBOutlet weak var announcePriceLabel: UILabel!
    @IBOutlet weak var announceCategoryLabel: UILabel!
    @IBOutlet weak var announceDataCreationLabel: UILabel!
    @IBOutlet weak var announceDescriptionTitleLabel: UILabel!
    @IBOutlet weak var announceDescriptionLabel: UILabel!
    @IBOutlet weak var announceEntityLabel: UILabel!
    
    var announceViewModel: AnnounceViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        configureAnnounce()
    }
    
    private func setupUI() {
        
        self.title = "Announce"
        self.announceDescriptionTitleLabel.text = "Description"
    }
    
    private func configureAnnounce() {
        
        self.announceTitleLabel.text = announceViewModel?.title
        self.announcePriceLabel.text = announceViewModel?.displayedPrice
        self.announceCategoryLabel.text = announceViewModel?.category.name
        
        self.announceDescriptionLabel.text = announceViewModel?.description
        
        self.announceEntityLabel.text = announceViewModel?.displayedUser
        self.announceDataCreationLabel.text = announceViewModel?.displayedDate
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        if let imageURL = announceViewModel?.thumbURL {
            imageView.loadImage(from: imageURL)
        } else {
            imageView.image = UIImage(named: "no-image")
        }

        return imageView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.size.height/3
    }
}
