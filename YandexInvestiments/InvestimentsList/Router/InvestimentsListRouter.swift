//
//  InvestimentListRouter.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 12.07.2021.
//

import Foundation
import UIKit

protocol InvestimentsListRouterProtocol {
    func showInvestimentCard(with model: InvestimentModel)
}

class InvestimentsListRouter: InvestimentsListRouterProtocol {
    private weak var viewController: UIViewController?
    
    public init(with viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showInvestimentCard(with model: InvestimentModel) {
        let module = UIStoryboard(name: "Card", bundle: nil)
        let cardController = module.instantiateViewController(withIdentifier: String(describing: CardViewController.self))
        viewController?.navigationController?.pushViewController(cardController, animated: true)
    }
}
