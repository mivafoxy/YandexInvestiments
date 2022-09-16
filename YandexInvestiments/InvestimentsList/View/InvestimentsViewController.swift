//
//  ViewController.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 08.06.2021.
//

import UIKit
import AddressBookUI
import AddressBook
import ContactsUI
import Contacts

protocol InvestimentsView: class {
    var presenter: InvestimentsListPresenterInput? { get set }
    func showStocks()
    func updateFavouriteView(model: InvestimentModel)
}

protocol InvestimentsSearchDelegate: class {
    func searchTicker(with name: String)
}

class InvestimentsViewController: UIViewController {

    @IBOutlet weak var selectorCollectionView: UICollectionView!
    @IBOutlet weak var stocksTableView: UITableView!
    
    private let tableCellId = String(describing: InvestimentsTableCell.self)
    private let selectorCellId = String(describing: InvestimentCollectionCell.self)
    
    // TODO: - make delegate for this.
    private var suggestionsViewController: SuggestionsViewController?
    
    private let selector = ["Stocks", "Favorites"]

    private var configurator: InvestimentsListConfiguratorProtocol = InvestimentsListConfigurator()
    public var presenter: InvestimentsListPresenterInput?
    
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
        
        configurator.configure(with: self)
        presenter?.configureView()
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
        suggestionsViewController?.delegate = self
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
        presenter?.stocksFiltered(with: investimentName)
    }
}

// MARK: - InvestimentsView

extension InvestimentsViewController: InvestimentsView {
    func showStocks() {
        reloadTableView()
    }
    
    func updateFavouriteView(model: InvestimentModel) {
        presenter?.tickerWasFavorited(model: model)
    }
}

// MARK: - UITableViewDataSource

extension InvestimentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = presenter?.getStocksCount() else {
            return 0
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId, for: indexPath) as? InvestimentsTableCell else {
            return UITableViewCell()
        }
        
        guard let presenter = presenter else {
            return UITableViewCell()
        }
        
        let models = presenter.getStocks()
        
        cell.setup(model: models[indexPath.item])
        cell.viewDelegate = self
        
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
        guard
            let cell = tableView.cellForRow(at: indexPath) as? InvestimentsTableCell,
            let model = cell.model
            else
        {
            return
        }
        
        presenter?.tickerClicked(model: model)
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
        
        collectionView.visibleCells.forEach { visibleCell in
            guard let visibleCell = visibleCell as? InvestimentCollectionCell else {
                return
            }
            visibleCell.makeUnselected()
        }
        
        cell.makeSelected()
        
        let isFavoriting = cell.sectionName.text == selector.last
        presenter?.selectorClicked(with: isFavoriting)
    }
}

// MARK: - UISeachResultsUpdating

extension InvestimentsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            return
        }
        
        print(text)
        
        removeSuggestionController()
        filterTable(with: text)
    }
}

// MARK: - UISearchBarDelegate

extension InvestimentsViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        addSuggestionController()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        removeSuggestionController()
        presenter?.searchCancelled()
    }
}


// MARK: - InvestimentsSearchDelegate

extension InvestimentsViewController: InvestimentsSearchDelegate {
    public func searchTicker(with name: String) {
        guard let searchTextField = navigationItem.searchController?.searchBar.searchTextField else {
            return
        }
        
        searchTextField.insertText(name)
    }
}
