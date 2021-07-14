//
//  InvestimentListPresenter.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 08.07.2021.
//

import Foundation

protocol InvestimentsListPresenterInput: class {
    func configureView()
    func stocksLoaded(tickers: [InvestimentModel])
    func tickerClicked(model: InvestimentModel)
    func selectorClicked(with flag: Bool)
    func getStocksCount() -> Int
    func getStocks() -> [InvestimentModel]
    func stocksFiltered(with text: String)
    func searchCancelled()
}

class InvestimentsListPresenter: InvestimentsListPresenterInput {
    private weak var view: InvestimentsView!
    
    private var isFavourtesView: Bool = false
    private var isFilteringView: Bool = false
    
    private var models: [InvestimentModel] = []
    private var filterText: String = ""
    
    var interactor: InvestimentsListInteractorInput?
    var router: InvestimentsListRouterProtocol?
    
    public init(view: InvestimentsView) {
        self.view = view
    }
    
    func configureView() {
        interactor?.loadInvestimentsCollections()
    }
    
    func stocksLoaded(tickers: [InvestimentModel]) {
        models = tickers
        
        for i in 0..<models.endIndex {
            if i%2 == 0 {
                models[i].isFavourite = true
            }
        }
        
        view.showStocks()
    }
    
    func tickerClicked(model: InvestimentModel) {
        router?.showInvestimentCard(with: model)
    }
    
    func selectorClicked(with flag: Bool) {
        isFavourtesView = flag
        view.showStocks()
    }
    
    func getStocksCount() -> Int {
        if isFilteringView {
            return getFilteredStocks().count
        } else if isFavourtesView {
            return getFavouritesStocks().count
        } else {
            return models.count
        }
    }
    
    func getStocks() -> [InvestimentModel] {
        if isFilteringView {
            return getFilteredStocks()
        } else if isFavourtesView {
            return getFavouritesStocks()
        } else {
            return models
        }
    }
    
    func stocksFiltered(with text: String) {
        filterText = text
        isFilteringView = true
        view.showStocks()
    }
    
    func searchCancelled() {
        isFilteringView = false
        view.showStocks()
    }
    
    private func getFilteredStocks() -> [InvestimentModel] {
        var filtered = models.filter { (model) in
            guard let symbol = model.symbol else {
                return false
            }
            
            return symbol.lowercased().contains(filterText.lowercased())
        }
        
        if isFavourtesView {
            filtered = filtered.filter { (model) in
                guard let isFavourite = model.isFavourite else {
                    return false
                }
                
                return isFavourite
            }
        }
        
        return filtered
    }
    
    private func getFavouritesStocks() -> [InvestimentModel] {
        let favorites = models.filter {
            $0.isFavourite!
        }
        
        return favorites
    }
}
