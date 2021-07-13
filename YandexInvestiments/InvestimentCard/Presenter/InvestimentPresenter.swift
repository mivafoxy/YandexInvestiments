//
//  CardPresenter.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 13.07.2021.
//

import Foundation

protocol InvestimentPresenterInput {
    func configureView()
}

class InvestimentPresenter: InvestimentPresenterInput {
    private weak var view: InvestimentView?
    
    public weak var model: InvestimentModel?
    
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
}
