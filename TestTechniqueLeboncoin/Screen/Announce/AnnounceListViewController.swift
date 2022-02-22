//
//  AnnounceListViewController.swift
//  TestTechniqueLeboncoin
//
//  Created by Gustavo Serra on 19/02/2022.
//

import UIKit

class AnnounceListViewController: UIViewController {
    enum Identifier {
        static let announceCellIdentifier = "AnnounceListViewController.Identifier.AnnounceCell"
    }
    
    @IBOutlet weak var announceCollectionView: UICollectionView!
    @IBOutlet weak var categoryMenuView: UIView!
    @IBOutlet weak var displayedCategoryLabel: UILabel!
    @IBOutlet weak var categoriesButton: UIButton!
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 10.0,left: 10.0,bottom: 10.0,right: 10.0)
    
    private lazy var viewModel: AnnounceListViewModel = {
        let viewModel = AnnounceListViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        setUpCollectionView()
        
        viewModel.delegate = self
        
        viewModel.fetchAnnounces()
    }
    
    private func setupUI() {
        self.categoryMenuView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.categoryMenuView.layer.borderWidth = 1.0
        self.categoryMenuView.layer.cornerRadius = self.categoryMenuView.frame.height / 2
        self.displayedCategoryLabel.text = "Toutes les catégories"
        self.categoriesButton.setTitle("Catégories", for: .normal)
    }
    
    private func updateUI() {
        self.displayedCategoryLabel.text = viewModel.filteredCategory != nil ? viewModel.filteredCategory?.name : "Toutes les catégories"
    }
    
    private func setUpCollectionView() {
        announceCollectionView.contentInsetAdjustmentBehavior = .always
        announceCollectionView.register(UINib(nibName: "AnnounceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AnnounceCell")
    }
    
    @IBAction func categoriesButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "segueToCategories", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToCategories" {
            let categoriesVC = segue.destination as! CategoryViewController
            categoriesVC.delegate = self
            categoriesVC.announceListViewModel = viewModel
        }
    }
}

extension AnnounceListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.announcesConfiguration.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard viewModel.announcesConfiguration.count > indexPath.row else {
            fatalError("numberOfRowsInSection is invalide compare the model")
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnnounceCell", for: indexPath) as? AnnounceCollectionViewCell else {
            fatalError("reusableCell is invalide")
        }
        
        let announceViewModel = viewModel.announcesConfiguration[indexPath.row]
        cell.configure(announceViewModel)
        
        return cell
    }
}

extension AnnounceListViewController: UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 2 * widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension AnnounceListViewController: AnnounceListDelegate {
    
    func announcesConfigDidFetch(_ announceListViewModel: AnnounceListViewModel) {
        announceCollectionView.reloadData()
    }
}

extension AnnounceListViewController: CategoryDelegate {
    
    func categoryDidSelect(_ categoryListViewModel: CategoryListViewModel) {
        viewModel.filteredCategory = categoryListViewModel.selectedCategory
        updateUI()
        announceCollectionView.reloadData()
    }
}
