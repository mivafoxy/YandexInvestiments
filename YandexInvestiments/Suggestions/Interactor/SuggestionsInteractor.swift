//
//  SuggestionsInteractor.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 02.08.2021.
//

import Foundation

protocol SuggestionsInteractorProtocol {
    func loadTrendings()
}

class SuggestionsInteractor: SuggestionsInteractorProtocol {
    private var presenter: SuggestionsPresenterProtocol
    
    public init(with presenter: SuggestionsPresenterProtocol) {
        self.presenter = presenter
    }
    
    public func loadTrendings() {
        QueryService.getMostWatched { data in
            guard let trendings = try? JSONDecoder().decode(QuotesInfo.self, from: data) else {
                return
            }
            
            var suggestions = [SuggestionsModel]()
            for trending in trendings.data {
                for name in trending.quotes {
                    suggestions.append(SuggestionsModel(name: name))
                }
            }
            
            DispatchQueue.main.async {
                self.presenter.trendsLoaded(suggestions)
            }
        }
    }
}
