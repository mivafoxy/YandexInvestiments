//
//  ViewController.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 08.06.2021.
//

import UIKit

class InvestimentsViewController: UIViewController {

    @IBOutlet weak var selectorCollectionView: UICollectionView!
    @IBOutlet weak var stocksTableView: UITableView!
    
    private let tableCellId = String(describing: InvestimentsTableCell.self)
    private let selectorCellId = String(describing: InvestimentCollectionCell.self)
    
    private let tableViewStub = [
        ("YNDX","Yandex,LLC","4 764,6 ₽","+55 ₽ (1,15%)"),
        ("AAPL", "Apple INC.", "$131.93", "+$0.12 (1,15%)"),
        ("GOOGL", "Alphabet Class A", "$1 825", "+$0.12 (1,15%)"),
        ("AMZN", "Amazon.com", "$3 204", "-$0.12 (1,15%)"),
        ("BAC", "Bank of America Corp", "$3 204", "+$0.12 (1,15%)"),
        ("MSFT", "Microsoft Corporation", "$3 204", "+$0.12 (1,15%)"),
        ("TSLA", "Tesla Motors", "$3 204", "+$0.12 (1,15%)"),
        ("MA", "Matercard", "$3 204", "+$0.12 (1,15%)")
    ]
    
    private let selector = ["Stocks", "Favorites"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stocksTableView.dataSource = self
        stocksTableView.delegate = self
        stocksTableView.register(UINib(nibName: String(describing: tableCellId), bundle: nil), forCellReuseIdentifier: tableCellId)
        
        selectorCollectionView.dataSource = self
        selectorCollectionView.register(UINib(nibName: selectorCellId, bundle: nil), forCellWithReuseIdentifier: selectorCellId)
        
        initSearchController()
    }

    private func initSearchController() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Find company or ticker"
        search.searchBar.delegate = self
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
    }

}

// MARK: - UITableViewDataSource

extension InvestimentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewStub.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId, for: indexPath) as! InvestimentsTableCell
        
        let stub = tableViewStub[indexPath.row]
        cell.setup(investimentName: stub.0, companyName: stub.1, price: stub.2, difference: stub.3)
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .gray
        } else {
            cell.backgroundColor = .white
        }
        
        return cell
    }
}

extension InvestimentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = tableView.cellForRow(at: indexPath) as? InvestimentsTableCell else {
            return
        }
        
        let module = UIStoryboard(name: "Card", bundle: nil)
        let cardController = module.instantiateViewController(withIdentifier: String(describing: CardViewController.self))
        navigationController?.pushViewController(cardController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension InvestimentsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        selector.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: selectorCellId, for: indexPath) as? InvestimentCollectionCell else {
            return UICollectionViewCell()
        }
        
        cell.setup(sectionName: selector[indexPath.item])
        
        return cell
    }
}

// MARK: - UISeachResultsUpdating

extension InvestimentsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        print(text)
    }
}

extension InvestimentsViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let board = UIStoryboard(name: "Suggestions", bundle: nil)
        let controller = board.instantiateViewController(withIdentifier: String(describing: SuggestionsViewController.self))
        navigationController?.pushViewController(controller, animated: true)
    }
}
