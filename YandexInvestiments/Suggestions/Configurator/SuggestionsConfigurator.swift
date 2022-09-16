//
//  SuggestionsConfigurator.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 02.08.2021.
//

import Foundation

protocol SuggestionsConfiguratorProtocol {
    func configure(with view: SuggestionsView)
}

class SuggestionsConfigurator: SuggestionsConfiguratorProtocol {
    func configure(with view: SuggestionsView) {
        let presenter = SuggestionsPresenter(with: view)
        
        let interactor = SuggestionsInteractor(with: presenter)
        presenter.interactor = interactor
        
        view.presenter = presenter
    }
}
