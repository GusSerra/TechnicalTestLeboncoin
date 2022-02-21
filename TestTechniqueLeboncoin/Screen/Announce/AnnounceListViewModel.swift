//
//  AnnounceListViewModel.swift
//  TestTechniqueLeboncoin
//
//  Created by Gustavo Serra on 19/02/2022.
//

import Foundation

protocol AnnounceListDelegate: AnyObject {
    func announcesDidFetch(_ announceListViewModel: AnnounceListViewModel)
}

class AnnounceListViewModel {
    
    private var announces: [Announce] = [] {
        didSet {
            self.delegate?.announcesDidFetch(self)
        }
    }
    
    var announcesConfiguration: [AnnounceViewModel] {
        announces.sorted { announceA, announceB in
            guard announceA.is_urgent == announceB.is_urgent else {
                return announceA.is_urgent
            }
            
            return announceA.creation_date < announceB.creation_date
        }
        .map { AnnounceViewModel(announce: $0) }
    }
    
    weak var delegate: AnnounceListDelegate?
    
    func fetchAnnounces() {
        
        let resource = Resource<[Announce]>(baseUrl: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") { data in
            
            return try? JSONDecoder().decode([Announce].self, from: data)
        }
        
        NetworkService().load(resource: resource) { [weak self] result in
            
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let announces):
                    if let safeAnnounces = announces {
                        self?.announces = safeAnnounces
                    }
            }
        }
    }
}
