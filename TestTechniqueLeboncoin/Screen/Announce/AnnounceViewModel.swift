//
//  AnnounceViewModel.swift
//  TestTechniqueLeboncoin
//
//  Created by Gustavo Serra on 19/02/2022.
//

import Foundation

enum UrgentAnnounce {
    case noturgent
    case urgent
}

struct AnnounceViewModel {
    let id: Int
    let title: String
    let creationDate: Date?
    let description: String
    let urgency: UrgentAnnounce
    let thumbURL: URL?
    let smallURL: URL?
    let price: Double
    var siret: String?
    
    init(announce: Announce) {
        self.id = announce.id
        self.title = announce.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        self.creationDate = dateFormatter.date(from: announce.creation_date)
        self.description = announce.description
        self.urgency = announce.is_urgent ? .urgent : .noturgent
        self.thumbURL = URL(string: announce.images_url.thumb ?? "")
        self.smallURL = URL(string: announce.images_url.small ?? "")
        self.price = announce.price
    }
    
    var displayedPrice: String {
        "\(price) €"
    }
}
