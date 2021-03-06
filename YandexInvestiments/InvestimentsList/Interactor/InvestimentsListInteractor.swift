//
//  InvestimentsListInteractor.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 08.07.2021.
//

import Foundation

protocol InvestimentsListInteractorInput {
    func loadInvestimentsCollections()
}

class InvestimentsListInteractor: InvestimentsListInteractorInput {
    private weak var presenter: InvestimentsListPresenterInput!
    private var investimentsList = [InvestimentModel]()
    
    public init(presenter: InvestimentsListPresenterInput) {
        self.presenter = presenter
    }
    
    public func loadInvestimentsCollections() {
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue(label: String(describing: InvestimentsListInteractor.self))
        
        dispatchGroup.enter()
        queue.async {
            dispatchGroup.enter()
            QueryService.getMarketStockCollections { data in
                guard let trendings = try? JSONDecoder().decode(Trendings.self, from: data) else {
                    dispatchGroup.leave()
                    return
                }
                print(trendings)
                
                for trending in trendings {
                    
                    let tickerNames = self.getSubarrayFrom(arr: trending.quotes, bound: 50)
                    
                    dispatchGroup.enter()
                    for tickerSubNames in tickerNames {
                        dispatchGroup.enter()
                        QueryService.getStockQuotes(tickerNames: Array(tickerSubNames)) { data in
                            guard let quotes = try? JSONDecoder().decode(Quotes.self, from: data) else {
                                dispatchGroup.leave()
                                return
                            }
                            
                            for quote in quotes {
                                let investimentModel =
                                    InvestimentModel(
                                        quote.symbol,
                                        quote.regularMarketPrice,
                                        quote.regularMarketChange,
                                        quote.regularMarketChangePercent,
                                        quote.shortName,
                                        quote.currency)

                                self.setTicketFavoriteIfNeeded(model: investimentModel)
                                
                                self.investimentsList.append(investimentModel)
                            }
                            
                            dispatchGroup.leave()
                        }
                    }
                    dispatchGroup.leave()
                }
                dispatchGroup.leave()
            }
            dispatchGroup.leave()
        }
        
        
        dispatchGroup.notify(queue: queue) {
            DispatchQueue.main.async {
                self.presenter.stocksLoaded(tickers: self.investimentsList)
            }
        }
    }
    
    public func setTicketFavoriteIfNeeded(model: InvestimentModel) {
        let entities = CoreDataService.loadDataFromDb()
        
        let hasModelInEntities = entities.contains { entity in
            return entity.name == model.symbol
        }
        
        if hasModelInEntities {
            model.isFavourite = true
        }
    }
    
    private func getSubarrayFrom(arr: [String], bound: Int) -> [[String]] {
        var subarrs = [[String]]()
        
        var subarr = [String]()
        for i in 0..<arr.count {
            if i != 0 && i % bound == 0 {
                subarrs.append(subarr)
                subarr = [String]()
            }
            
            subarr.append(arr[i])
        }
        
        subarrs.append(subarr)
        
        return subarrs
    }
}
