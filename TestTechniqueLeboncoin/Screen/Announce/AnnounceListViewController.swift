//
//  AnnounceListViewController.swift
//  TestTechniqueLeboncoin
//
//  Created by Gustavo Serra on 19/02/2022.
//

import UIKit

class AnnounceListViewController: UIViewController {
    
    private lazy var viewModel: AnnounceListViewModel = {
        let viewModel = AnnounceListViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        viewModel.fetchAnnounces()
    }
}

extension AnnounceListViewController: AnnounceListDelegate {
    
    func announcesDidFetch(_ announceListViewModel: AnnounceListViewModel) {
        let test = viewModel.announcesConfiguration
        print(test)
    }
}
