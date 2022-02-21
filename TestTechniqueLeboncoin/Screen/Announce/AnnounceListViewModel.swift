//
//  AnnounceListViewModel.swift
//  TestTechniqueLeboncoin
//
//  Created by Gustavo Serra on 19/02/2022.
//

import Foundation

struct AnnounceListViewModel {
    
    private var announces = [Announce]()
    
    var announcesConfiguration: [AnnounceViewModel] {
        announces.map { AnnounceViewModel(announce: $0) }
    }
    
    func fetchAnnounces() {
        
        let resource = Resource<[Announce]>(baseUrl: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") { data in
            
            return try? JSONDecoder().decode([Announce].self, from: data)
        }
        
        NetworkService().load(resource: resource) { result in
            
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let announces):
                    if let safeAnnounces = announces {
                        print(safeAnnounces)
                    }
            }
        }
    }
}
