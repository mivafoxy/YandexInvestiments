//
//  ViewController.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 08.06.2021.
//

import UIKit

struct InvestimentModel {
    let investimentName: String
    let companyName: String
    let price: String
    let dynamic: String
    let isFavourite: Bool
    
    init(_ investimentName: String, _ companyName: String, _ price: String, _ dynamic: String, _ isFavourite: Bool) {
        self.investimentName = investimentName
        self.companyName = companyName
        self.price = price
        self.dynamic = dynamic
        self.isFavourite = isFavourite
    }
}

class InvestimentsViewController: UIViewController {

    @IBOutlet weak var selectorCollectionView: UICollectionView!
    @IBOutlet weak var stocksTableView: UITableView!
    
    private let tableCellId = String(describing: InvestimentsTableCell.self)
    private let selectorCellId = String(describing: InvestimentCollectionCell.self)
    
    // TODO: - make delegate for this.
    private var suggestionsViewController: SuggestionsViewController?
    
    private let tableViewStub = [
        InvestimentModel("YNDX","Yandex,LLC","4 764,6 ₽","+55 ₽ (1,15%)", false),
        InvestimentModel("AAPL", "Apple INC.", "$131.93", "+$0.12 (1,15%)", true),
        InvestimentModel("GOOGL", "Alphabet Class A", "$1 825", "+$0.12 (1,15%)", false),
        InvestimentModel("AMZN", "Amazon.com", "$3 204", "-$0.12 (1,15%)", false),
        InvestimentModel("BAC", "Bank of America Corp", "$3 204", "+$0.12 (1,15%)", false),
        InvestimentModel("MSFT", "Microsoft Corporation", "$3 204", "+$0.12 (1,15%)", true),
        InvestimentModel("TSLA", "Tesla Motors", "$3 204", "+$0.12 (1,15%)", true),
        InvestimentModel("MA", "Matercard", "$3 204", "+$0.12 (1,15%)", true)
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
        cell.setup(model: stub)
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .gray
        } else {
            cell.backgroundColor = .white
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

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

// MARK: - UISearchBarDelegate

extension InvestimentsViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let board = UIStoryboard(name: "Suggestions", bundle: nil)
        guard let controller = board.instantiateViewController(withIdentifier: String(describing: SuggestionsViewController.self)) as? SuggestionsViewController else {
            return
        }
        suggestionsViewController = controller
        controller.willMove(toParent: self)
        addChild(controller)
        
        controller.view.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.view.addSubview(controller.view)
            controller.view.alpha = 1
        }
        
        controller.didMove(toParent: self)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        suggestionsViewController?.willMove(toParent: nil)
        
        UIView.animate(withDuration: 0.3) {
            self.suggestionsViewController?.view.alpha = 0
            self.suggestionsViewController?.view.removeFromSuperview()
            self.suggestionsViewController?.removeFromParent()
        }
    }
}
