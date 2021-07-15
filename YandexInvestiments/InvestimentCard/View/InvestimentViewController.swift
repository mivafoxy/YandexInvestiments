//
//  CardViewController.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 10.06.2021.
//

import UIKit
import MobileAnalyticsChartSwift

protocol InvestimentView: class {
    var presenter: InvestimentPresenterInput? { get set }
    
    func setupPriceLabel(with string: String)
    func setupBuyButtonLabbel(with price: String)
    func setupDynamicLabel(with dynamic: String, _ isGrowing: Bool)
    func setupNavBarTitle(with title: String)
    func showHistoricalData()
}

class InvestimentViewController: UIViewController {
    @IBOutlet weak var chartView: UIView!
    
    @IBOutlet weak var sectionsCollection: UICollectionView!
    
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dynamicLabel: UILabel!
    
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var threeMonthsButton: UIButton!
    
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
        presenter?.loadHistoricalData(for: HistoricalIntervals.day)
    }
    
    @IBAction func dayButtonClicked(_ sender: Any) {
        presenter?.loadHistoricalData(for: HistoricalIntervals.day)
    }
    
    @IBAction func weekButtonClicked(_ sender: Any) {
        presenter?.loadHistoricalData(for: HistoricalIntervals.week)
    }
    
    @IBAction func monthButtonClicked(_ sender: Any) {
        presenter?.loadHistoricalData(for: HistoricalIntervals.month)
    }
    
    @IBAction func threeMonthsButtonClicked(_ sender: Any) {
        presenter?.loadHistoricalData(for: HistoricalIntervals.threeMonth)
    }
    
    private func configureChart(with values: ChartData) {
        
        UIView.animate(withDuration: 0.3) {
            self.chartView.subviews.forEach { (element) in
                element.alpha = 0
                element.removeFromSuperview()
            }
        }
        
        // Creating a fade animation configuration
        let fadeAnimation = ChartFadeAnimation(
          fadeOutColor: UIColor(white: 219 / 255, alpha: 1),
          fadeInColor: UIColor(white: 236 / 255, alpha: 1),
          startDuration: 0.2,
          fadeOutDuration: 0.6,
          fadeInDuration: 0.6
        )

        // Creating date formatters
        let dmmmyyyyDateFormatter = DateFormatter()
        dmmmyyyyDateFormatter.dateFormat = "d MMM yyyy"
        let dmmmDateFormatter = DateFormatter()
        dmmmDateFormatter.dateFormat = "d MMM"

        let path = ChartPath(
          type: .horizontalQuadratic,
          color: UIColor(red: 51 / 255, green: 102 / 255, blue: 1, alpha: 1),
          minWidth: 1.0,
          maxWidth: 5.0,
          fadeAnimation: fadeAnimation
        )
        let chartRenderConfiguration = ChartRenderConfiguration(
          unit: .quantity,
          path: path,
          gradient: nil
        )
        let analyticsChartSpriteKitViewModel = AnalyticsChartSpriteKitViewModel(
          data: values,
          configuration: chartRenderConfiguration
        )

        // Creating a range label configuration
        let rangeLabel = ChartRangeLabel(
          color: UIColor(white: 102 / 255, alpha: 1),
          font: .systemFont(ofSize: 13, weight: .regular),
          dateFormatter: dmmmyyyyDateFormatter,
          insets: UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        )

        // Creating a xAxis configuration
        let xAxis = ChartXAxis(
          labelColor: UIColor(white: 179 / 255, alpha: 1),
          labelFont: .systemFont(ofSize: 11, weight: .regular),
          dateFormatter: dmmmDateFormatter,
          insets: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0),
          margins: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16),
          zoomFactorLabels: 1.5
        )

        // Creating a yAxis configuration
        let yAxis = ChartYAxis(
          labelColor: UIColor(white: 179 / 255, alpha: 1),
          labelFont: .systemFont(ofSize: 11, weight: .regular),
          labelInsets: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 0),
          lineColor: UIColor(white: 0, alpha: 0.12),
          lineWidth: 1
        )

        // Creating a zero line
        let zeroLine = ChartZeroLine(
            color: UIColor(white: 236 / 255, alpha: 1),
            width: 1
        )

        // Creating a gesture state configuration
        let gestureState = ChartGestureState(
          swipeIsActive: true,
          pinchIsActive: true,
          handleIsActive: true
        )

        // Creating a animation configuration
        let animation = ChartAnimation(
          redrawDuration: 0.2
        )

        // Creating a definition configuration
        let definitionView = ChartDefinitionView(
          backgroundColor: UIColor(red: 0.043, green: 0.09, blue: 0.204, alpha: 1),
          valueLabelFont: .systemFont(ofSize: 13),
          valueLabelColor: UIColor(white: 0.95, alpha: 1.0),
          dateLabelFont: .systemFont(ofSize: 11),
          dateLabelColor: UIColor(white: 0.7, alpha: 1.0),
          dateFormatter: dmmmyyyyDateFormatter
        )
        let definition = ChartDefinition(
          line: ChartDefinitionLine(color: UIColor(white: 236 / 255, alpha: 1), width: 1),
          point: ChartDefinitionPoint(minRadius: 4, maxRadius: 8),
          view: definitionView,
          fadeAnimation: fadeAnimation
        )

        // Creating a chart sprite kit module input data
        let chartViewModel = AnalyticsChartSpriteKitModuleInputData(
          viewModels: [analyticsChartSpriteKitViewModel],
          renderConfiguration: RenderConfiguration(
            rangeLabel: rangeLabel,
            xAxis: xAxis,
            yAxis: yAxis,
            zeroLine: zeroLine,
            gestureState: gestureState,
            animation: animation,
            definition: definition,
            backgroundColor: UIColor(white: 247 / 255, alpha: 1),
            chartInsets: .zero,
            chartMargins: UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0),
            fadeInDuration: 0.3,
            fadeOutDuration: 0.3
          ),
          calculatorConfiguration: CalculatorConfiguration(
            minStaticValue: nil,
            maxStaticValue: nil
          )
        )
        
        let (chart, _) = AnalyticsChartSpriteKitAssembly.makeModule(inputData: chartViewModel)
        chart.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            chart.translatesAutoresizingMaskIntoConstraints = false
            self.chartView.addSubview(chart)
            let constraints = [
                chart.topAnchor.constraint(equalTo: self.chartView.topAnchor),
                chart.leadingAnchor.constraint(equalTo: self.chartView.leadingAnchor),
                chart.trailingAnchor.constraint(equalTo: self.chartView.trailingAnchor),
                chart.bottomAnchor.constraint(equalTo: self.chartView.bottomAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
            chart.alpha = 1
        }
        
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
    
    func showHistoricalData() {
        guard let presenter = presenter else {
            return
        }
        
        let items = presenter.getHistoricalData()
        
        let dates = items.map { item in
            return (item.itemDate)
        }
        let prices = items.map { item in
            return CGFloat(item.itemOpen)
        }
        
        let chartData = ChartData(values: prices, dates: dates)
        
        configureChart(with: chartData)
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
