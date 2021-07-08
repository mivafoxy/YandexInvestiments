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
    var isFavourite: Bool
    
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
    
    private var filteredTableViewStub: [InvestimentModel] = []
    private var favoritingTableViewStub: [InvestimentModel] = []
    
    private let selector = ["Stocks", "Favorites"]
    
    private var isFiltering = false
    private var filteringText = ""
    private var isFavoriting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stocksTableView.dataSource = self
        stocksTableView.delegate = self
        stocksTableView.register(UINib(nibName: String(describing: tableCellId), bundle: nil), forCellReuseIdentifier: tableCellId)
        
        selectorCollectionView.dataSource = self
        selectorCollectionView.delegate = self
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

    private func addSuggestionController() {
        let board = UIStoryboard(name: "Suggestions", bundle: nil)
        let boardId = String(describing: SuggestionsViewController.self)
        guard let controller = board.instantiateViewController(withIdentifier: boardId) as? SuggestionsViewController else {
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
    
    private func removeSuggestionController() {
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.suggestionsViewController?.view.alpha = 0
            },
            completion: { (isCompleted) in
                if isCompleted {
                    self.suggestionsViewController?.view.removeFromSuperview()
                    self.suggestionsViewController?.removeFromParent()
                    self.suggestionsViewController?.willMove(toParent: nil)
                }
            })
    }
    
    private func reloadTableView() {
        UIView.transition(
            with: stocksTableView,
            duration: 0.35,
            options: .transitionCrossDissolve) {
            self.stocksTableView.reloadData()
        }
    }
    
    private func filterTable(with investimentName: String) {
        filteringText = investimentName
        
        if isFiltering {
            filteredTableViewStub = tableViewStub.filter {
                $0.investimentName.lowercased().contains(filteringText.lowercased())
            }
        }
        
        if isFavoriting {
            filteredTableViewStub = filteredTableViewStub.filter {
                $0.isFavourite
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension InvestimentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredTableViewStub.count
        } else if isFavoriting {
            return favoritingTableViewStub.count
        } else {
            return tableViewStub.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId, for: indexPath) as! InvestimentsTableCell
        
        if isFiltering {
            cell.setup(model: filteredTableViewStub[indexPath.row])
        } else if isFavoriting {
            cell.setup(model: favoritingTableViewStub[indexPath.row])
        } else {
            cell.setup(model: tableViewStub[indexPath.row])
        }
        
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
        
        if selector[indexPath.item] == selector[selector.startIndex] {
            cell.makeSelected()
        } else {
            cell.makeUnselected()
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension InvestimentsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? InvestimentCollectionCell else {
            return
        }
        
        cell.makeSelected()
        
        collectionView.visibleCells.forEach { visibleCell in
            guard let visibleCell = visibleCell as? InvestimentCollectionCell else {
                return
            }
            visibleCell.makeUnselected()
        }
        
        isFavoriting = cell.sectionName.text == selector.last
        
        if isFavoriting {
            favoritingTableViewStub = tableViewStub.filter {
                $0.isFavourite
            }
        }
        
        if isFiltering {
            filterTable(with: filteringText)
        }
        
        reloadTableView()
    }
}

// MARK: - UISeachResultsUpdating

extension InvestimentsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            filteredTableViewStub = []
            reloadTableView()
            return
        }
        print(text)
        removeSuggestionController()
        
        filterTable(with: text)
        reloadTableView()
    }
}

// MARK: - UISearchBarDelegate

extension InvestimentsViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        addSuggestionController()
        isFiltering = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        removeSuggestionController()
        isFiltering = false
        
        reloadTableView()
    }
}
