//
//  SuggestionsPrese.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 02.08.2021.
//

import Foundation

protocol SuggestionsPresenterProtocol {
    func callToLoadTrends()
    func trendsLoaded(_ suggestions: [SuggestionsModel])
    func getTrendings() -> [SuggestionsModel]
}

class SuggestionsPresenter: SuggestionsPresenterProtocol {
    public var interactor: SuggestionsInteractorProtocol?
    
    private var suggestions: [SuggestionsModel] = []
    private let view: SuggestionsView
    
    public init(with view: SuggestionsView) {
        self.view = view
    }
    
    public func trendsLoaded(_ suggestions: [SuggestionsModel]) {
        self.suggestions = suggestions
        view.showSuggestions()
    }
    
    public func getTrendings() -> [SuggestionsModel] {
        return suggestions
    }
    
    public func callToLoadTrends() {
        interactor?.loadTrendings()
    }
}
