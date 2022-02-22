//
//  CategoryViewController.swift
//  TestTechniqueLeboncoin
//
//  Created by Gustavo Serra on 22/02/2022.
//

import UIKit

class CategoryViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoriesTableView: UITableView!
    
    private lazy var viewModel: CategoryListViewModel = {
        let viewModel = CategoryListViewModel()
        return viewModel
    }()
    
    var announceListViewModel: AnnounceListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = "Catégories"
        
        guard let safeAnnounceListViewModel = announceListViewModel else {
            fatalError("announceListViewModel is invalid")
        }
        viewModel.loadCategories(from: safeAnnounceListViewModel)
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categoriesConfiguration.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard viewModel.categoriesConfiguration.count > indexPath.row else {
            fatalError("numberOfRowsInSection is invalide compare the model")
        }
        
        let cell = categoriesTableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let categoryViewModel = viewModel.categoriesConfiguration[indexPath.row]
        cell.textLabel?.text = categoryViewModel.name
        
        return cell
    }
}
