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
    let category: AnnounceCategory
    let creationDate: Date?
    let description: String
    let urgency: UrgentAnnounce
    let thumbURL: URL?
    let smallURL: URL?
    let price: Double
    let siret: String?
    
    init(announce: Announce, category: AnnounceCategory) {
        self.id = announce.id
        self.title = announce.title
        self.category = category
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        self.creationDate = dateFormatter.date(from: announce.creation_date)
        self.description = announce.description
        self.urgency = announce.is_urgent ? .urgent : .noturgent
        self.thumbURL = URL(string: announce.images_url.thumb ?? "")
        self.smallURL = URL(string: announce.images_url.small ?? "")
        self.price = announce.price
        self.siret = announce.siret
    }
    
    var displayedPrice: String {
        "\(price) €"
    }
    
    var displayedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        guard let safeCreationDate = creationDate else {
            return "Date de la création unconnu"
        }
        let stringData = dateFormatter.string(from: safeCreationDate)
        return "Créé le \(stringData)"
    }
    
    var displayedUser: String {
        guard let safeSiret = siret else {
            return "Créé par un utilisateur"
        }
        return "Créé par la société siret : \(safeSiret)"
    }
}
