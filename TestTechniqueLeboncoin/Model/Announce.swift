//
//  Announce.swift
//  TestTechniqueLeboncoin
//
//  Created by Gustavo Serra on 19/02/2022.
//

import Foundation

struct Announce: Codable {
    let id: Int
    let title: String
    let category_id: Int64
    let creation_date: String
    let description: String
    let is_urgent: Bool
    let images_url: Image
    let price: Double
    let siret: String?
}

struct Image: Codable {
    let small: String?
    let thumb: String?
}
