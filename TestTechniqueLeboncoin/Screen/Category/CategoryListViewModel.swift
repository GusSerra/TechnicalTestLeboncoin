//
//  CategoryListViewModel.swift
//  TestTechniqueLeboncoin
//
//  Created by Gustavo Serra on 22/02/2022.
//

import Foundation

class CategoryListViewModel {
    
    private var categories: [Category] = []
    
    var categoriesConfiguration: [CategoryViewModel] {
        categories.sorted(by: { $0.name < $1.name })
            .map { CategoryViewModel(category: $0) }
    }
    
    private var selectedCategory: Category?
    
    func loadCategories(from announceListViewModel: AnnounceListViewModel) {
        self.categories = announceListViewModel.categories
    }
}
