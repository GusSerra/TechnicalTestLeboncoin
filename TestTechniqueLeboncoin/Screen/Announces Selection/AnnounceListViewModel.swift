//
//  AnnounceListViewModel.swift
//  TestTechniqueLeboncoin
//
//  Created by Gustavo Serra on 19/02/2022.
//

import Foundation

protocol AnnounceListDelegate: AnyObject {
    func announcesConfigDidFetch(_ announceListViewModel: AnnounceListViewModel)
}

class AnnounceListViewModel {
    
    let networkService: NetworkServiceProtocol?
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    private var announces: [Announce] = [] {
        didSet {
            self.fetchCategories()
        }
    }
    
    var categories: [AnnounceCategory] = [] {
        didSet {
            self.delegate?.announcesConfigDidFetch(self)
        }
    }
    
    var filteredCategory: AnnounceCategory?
    
    var announcesConfiguration: [AnnounceViewModel] {
        announces
        .filter { announce in
            guard let category = filteredCategory else {
                return true
            }
            return announce.category_id == category.id
        }
        .sorted { announceA, announceB in
            guard announceA.is_urgent == announceB.is_urgent else {
                return announceA.is_urgent
            }
            
            return announceA.creation_date > announceB.creation_date
        }
        .map { announce in
            guard let announceCategory = categories.first(where: { $0.id == announce.category_id }) else {
                fatalError("there is no category for the cetegory announce id")
            }
            return AnnounceViewModel(announce: announce, category: announceCategory)
        }
    }
    
    weak var delegate: AnnounceListDelegate?
    
    func fetchAnnounces() {
        
        let resource = Resource<[Announce]>(baseUrl: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") { data in
            
            return try? JSONDecoder().decode([Announce].self, from: data)
        }
        
        networkService?.load(resource: resource) { [weak self] result in
            
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
    
    private func fetchCategories() {
        
        let resource = Resource<[AnnounceCategory]>(baseUrl: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json") { data in
            
            return try? JSONDecoder().decode([AnnounceCategory].self, from: data)
        }
        
        networkService?.load(resource: resource) { [weak self] result in
            
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let categories):
                    if let safeCategories = categories {
                        self?.categories = safeCategories
                    }
            }
        }
    }
}
