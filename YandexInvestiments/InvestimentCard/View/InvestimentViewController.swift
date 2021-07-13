//
//  CardViewController.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 10.06.2021.
//

import UIKit

protocol InvestimentView: class {
    var presenter: InvestimentPresenterInput? { get set }
    func setupPriceLabel(with string: String)
    func setupBuyButtonLabbel(with price: String)
    func setupDynamicLabel(with dynamic: String, _ isGrowing: Bool)
    func setupNavBarTitle(with title: String)
}

class InvestimentViewController: UIViewController {

    @IBOutlet weak var sectionsCollection: UICollectionView!
    
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dynamicLabel: UILabel!
    
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var halfYearButton: UIButton!
    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var allButton: UIButton!
    
    private let cellId = String(describing: InvestimentViewController.self)
    
    public var configurator: InvestimentConfiguratorProtocol? = InvestimentConfigurator()
    public var presenter: InvestimentPresenterInput?
    
    private let sections = [
        "Chart",
        "Sumary",
        "News",
        "Forecasts",
        "Ideas"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sectionsCollection.dataSource = self
        sectionsCollection.register(
            UINib(nibName: String(describing: CardViewCell.self), bundle: nil), forCellWithReuseIdentifier: cellId)
        
        presenter?.configureView()
    }
}

// MARK: - CardView

extension InvestimentViewController: InvestimentView {
    func setupBuyButtonLabbel(with price: String) {
        let title = "Buy for \(price)"
        buyButton.setTitle(title, for: .normal)
    }
    
    func setupDynamicLabel(with dynamic: String, _ isGrowing: Bool) {
        dynamicLabel.text = dynamic
        dynamicLabel.textColor = isGrowing ? .green : .red
        dynamicLabel.sizeToFit()
    }
    
    func setupPriceLabel(with string: String) {
        priceLabel.text = string
        priceLabel.sizeToFit()
    }
    
    func setupNavBarTitle(with title: String) {
        navigationItem.title = title
    }
}

// MARK: - UICollectionViewDataSource

extension InvestimentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CardViewCell else {
            return UICollectionViewCell()
        }
        
        cell.sectionName.font = .systemFont(ofSize: 18.0)
        cell.setup(sectionName: sections[indexPath.row])
        
        return cell
    }
}
