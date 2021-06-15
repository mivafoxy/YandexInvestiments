//
//  SuggestionsViewController.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 11.06.2021.
//

import UIKit

class SuggestionsViewController: UIViewController {
    @IBOutlet weak var popularsList: UICollectionView!
    @IBOutlet weak var searchedList: UICollectionView!
    
    private let popularsDataSource = PopularRequestsDataSource()
    private let searchedDataSource = SearchedDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nib = UINib(nibName: String(describing: SuggestionCollectionCell.self), bundle: nil)
        popularsList.register(nib, forCellWithReuseIdentifier: PopularRequestsDataSource.cellId)
        popularsList.dataSource = popularsDataSource
        
        searchedList.register(nib, forCellWithReuseIdentifier: SearchedDataSource.cellId)
        searchedList.dataSource = searchedDataSource
    }
}

class PopularRequestsDataSource: NSObject, UICollectionViewDataSource {
    public static let cellId = String(describing: PopularRequestsDataSource.self)
    private let popularsList = [ "Apple", "Amazon", "Google", "Tesla", "Microsoft", "First Solar", "Alibaba", "Facebook", "Mastercard" ]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        popularsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularRequestsDataSource.cellId, for: indexPath) as? SuggestionCollectionCell else {
            return UICollectionViewCell()
        }
        
        cell.setup(suggestionName: popularsList[indexPath.item])
        return cell
    }
}

class SearchedDataSource: NSObject, UICollectionViewDataSource {
    public static let cellId = String(describing: SearchedDataSource.self)
    private let searchedList = [ "Nvidia", "Nokia", "Yandex", "GM", "Microsoft", "Baidu", "Intel", "AMD", "Visa", "Bank of America" ]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchedDataSource.cellId, for: indexPath) as? SuggestionCollectionCell else {
            return UICollectionViewCell()
        }
        
        cell.setup(suggestionName: searchedList[indexPath.item])
        return cell
    }
}
