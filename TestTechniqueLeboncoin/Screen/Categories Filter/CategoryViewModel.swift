//
//  CategoryViewModel.swift
//  TestTechniqueLeboncoin
//
//  Created by Gustavo Serra on 22/02/2022.
//

import Foundation

struct CategoryViewModel {
    let id: Int64
    let name: String
    
    init(category: Category) {
        self.id = category.id
        self.name = category.name
    }
}
