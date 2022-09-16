//
//  SuggestionsViewController.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 11.06.2021.
//

import UIKit

protocol SuggestionsView: class {
    var presenter: SuggestionsPresenterProtocol? { get set }
    func showSuggestions()
    func suggestionClicked(_ model: SuggestionsModel)
}

class SuggestionsViewController: UIViewController, SuggestionsView {
    public var presenter: SuggestionsPresenterProtocol?
    public var delegate: InvestimentsSearchDelegate?
    
    @IBOutlet weak var popularsList: UICollectionView!
    
    private let cellId = String(describing: SuggestionsViewController.self)
    private let configurator: SuggestionsConfiguratorProtocol = SuggestionsConfigurator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nib = UINib(nibName: String(describing: SuggestionCollectionCell.self), bundle: nil)
        popularsList.register(nib, forCellWithReuseIdentifier: cellId)
        popularsList.dataSource = self
        popularsList.delegate = self
        
        configurator.configure(with: self)
        presenter?.callToLoadTrends()
    }
    
    public func showSuggestions() {
        self.popularsList.reloadData()
    }
    
    public func suggestionClicked(_ model: SuggestionsModel) {
        delegate?.searchTicker(with: model.name)
    }
}

// MARK: - UICollectionViewDataSource

extension SuggestionsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0 }
        return presenter.getTrendings().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? SuggestionCollectionCell else {
            return UICollectionViewCell()
        }
        
        guard let presenter = presenter else {
            return UICollectionViewCell()
        }
        
        let model = presenter.getTrendings()[indexPath.item]
        cell.setup(suggestionsModel: model)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension SuggestionsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SuggestionCollectionCell else {
            return
        }
        
        guard let model = cell.suggestionsModel else {
            return
        }
        
        suggestionClicked(model)
    }
}
