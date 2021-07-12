//
//  InvestimentListConfigurator.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 12.07.2021.
//

import Foundation
import UIKit

protocol InvestimentsListConfiguratorProtocol {
    func configure(with viewController: InvestimentsView)
}

public class InvestimentsListConfigurator: InvestimentsListConfiguratorProtocol {
    func configure(with viewController: InvestimentsView) {
        let presenter = InvestimentsListPresenter(view: viewController)
        let interactor = InvestimentsListInteractor(presenter: presenter)
        let router = InvestimentsListRouter(with: viewController as! UIViewController)
        
        presenter.interactor = interactor
        presenter.router = router
        viewController.presenter = presenter
    }
}
