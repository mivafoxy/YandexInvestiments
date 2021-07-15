//
//  InvestimentCardInteractor.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 14.07.2021.
//

import Foundation

protocol InvestimentCardInteractorInput {
    func loadInvestimentHistory(for model: InvestimentModel, with interval: HistoricalIntervals)
}

enum HistoricalIntervals: String {
    case day = "1d"
    case week = "1wk"
    case month = "1mo"
    case threeMonth = "3mo"
}

class InvestimentCardInteractor: InvestimentCardInteractorInput {
    private weak var presenter: InvestimentPresenterInput?
    
    public init(presenter: InvestimentPresenterInput) {
        self.presenter = presenter
    }
    
    func loadInvestimentHistory(for model: InvestimentModel, with interval: HistoricalIntervals) {
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue(label: String(describing: InvestimentCardInteractor.self))
        
        guard let symbol = model.symbol else {
            return
        }
        
        var models = [InvestimentCardModel]()
        
        dispatchGroup.enter()
        queue.async {
            dispatchGroup.enter()
            QueryService.getHistoricData(of: symbol, with: interval.rawValue) { (data) in
                let historicalData = try? JSONDecoder().decode(HistoricalData.self, from: data)
                guard let dataItems = historicalData?.items else {
                    return
                }
                
                for item in dataItems {
                    let model = InvestimentCardModel(timestamp: item.key, itemOpen: item.value.itemOpen!)
                    models.append(model)
                }
                
                dispatchGroup.leave()
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: queue) {
            DispatchQueue.main.async {
                self.presenter?.historicalDataLoaded(models: models)
            }
        }
    }
}
