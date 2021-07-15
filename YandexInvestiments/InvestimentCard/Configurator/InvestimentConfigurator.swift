//
//  InvestimentConfigurator.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 13.07.2021.
//

import Foundation

protocol InvestimentConfiguratorProtocol {
    func configure(with model: InvestimentModel, and view: InvestimentView)
}

class InvestimentConfigurator: InvestimentConfiguratorProtocol {
    func configure(with model: InvestimentModel, and view: InvestimentView) {
        let presenter = InvestimentPresenter(with: view)
        let interactor = InvestimentCardInteractor(presenter: presenter)
        
        view.presenter = presenter
        presenter.model = model
        presenter.interactor = interactor
    }
}
