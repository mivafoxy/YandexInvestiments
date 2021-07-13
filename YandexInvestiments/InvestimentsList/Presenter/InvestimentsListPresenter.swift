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
}

class InvestimentsListPresenter: InvestimentsListPresenterInput {
    private weak var view: InvestimentsView!
    
    
    var interactor: InvestimentsListInteractorInput?
    var router: InvestimentsListRouterProtocol?
    
    public init(view: InvestimentsView) {
        self.view = view
    }
    
    func configureView() {
        interactor?.loadInvestimentsCollections()
    }
    
    func stocksLoaded(tickers: [InvestimentModel]) {
        view.showStocks(models: tickers)
    }
    
    func tickerClicked(model: InvestimentModel) {
        router?.showInvestimentCard(with: model)
    }
}
