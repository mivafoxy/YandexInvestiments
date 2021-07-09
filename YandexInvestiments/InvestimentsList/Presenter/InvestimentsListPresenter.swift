//
//  InvestimentListPresenter.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 08.07.2021.
//

import Foundation

protocol InvestimentsListPresenterInput {
    var view: InvestimentsView? { get set }
    var interactor: InvestimentsListInteractorInput? { get set }
    func showStocks(tickers: [InvestimentModel])
}

class InvestimentsListPresenter: InvestimentsListPresenterInput {
    var interactor: InvestimentsListInteractorInput?
    var view: InvestimentsView?
    
    func showStocks(tickers: [InvestimentModel]) {
        view?.showStocks(models: tickers)
    }
}
