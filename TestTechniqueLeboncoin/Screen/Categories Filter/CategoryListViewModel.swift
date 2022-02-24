//
//  CategoryListViewModel.swift
//  TestTechniqueLeboncoin
//
//  Created by Gustavo Serra on 22/02/2022.
//

import Foundation

class CategoryListViewModel {
    
    private var categories: [AnnounceCategory] = []
    
    var categoriesConfiguration: [CategoryViewModel] {
        categories.sorted(by: { $0.name < $1.name })
            .map { CategoryViewModel(category: $0) }
    }
    
    var selectedCategory: AnnounceCategory?
    
    func loadCategories(from announceListViewModel: AnnounceListViewModel) {
        self.categories = announceListViewModel.categories
    }
    
    func userSelecetdCategory(with id: Int64) {
        
        guard let category = categories.first(where: { $0.id == id }) else {
            fatalError("the id of the category is invalid")
        }
        
        selectedCategory = category
    }
}
