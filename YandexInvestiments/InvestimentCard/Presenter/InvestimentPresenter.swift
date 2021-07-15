//
//  CardPresenter.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 13.07.2021.
//

import Foundation

protocol InvestimentPresenterInput: class {
    func configureView()
    func loadHistoricalData(for historicInterval: HistoricalIntervals)
    func historicalDataLoaded(models: [InvestimentCardModel])
    func getHistoricalData() -> [InvestimentCardModel]
}

class InvestimentPresenter: InvestimentPresenterInput {
    private weak var view: InvestimentView?
    private var historicalModels = [InvestimentCardModel]()
    
    public weak var model: InvestimentModel?
    public var interactor: InvestimentCardInteractorInput?
    
    
    public init(with view: InvestimentView) {
        self.view = view
    }
    
    public func configureView() {
        guard let model = model else {
            return
        }

        view?.setupPriceLabel(with: model.regularPrice)
        view?.setupDynamicLabel(with: model.dynamic, model.isGrowing)
        view?.setupBuyButtonLabbel(with: model.regularPrice)
        view?.setupNavBarTitle(with: model.symbol!)
    }
    
    public func historicalDataLoaded(models: [InvestimentCardModel]) {
        historicalModels = models.sorted { (left, right) in
            left.itemDate < right.itemDate
        }
        
        view?.showHistoricalData()
    }
    
    public func getHistoricalData() -> [InvestimentCardModel] {
        return historicalModels
    }
    
    public func loadHistoricalData(for historicInterval: HistoricalIntervals) {
        guard let model = model else {
            return
        }
        
        interactor?.loadInvestimentHistory(for: model, with: historicInterval)
    }
}
