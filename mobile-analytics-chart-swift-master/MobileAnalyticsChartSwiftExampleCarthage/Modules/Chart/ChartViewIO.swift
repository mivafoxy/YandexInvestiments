import UIKit

/// Chart view input
protocol ChartViewInput: AnyObject {
    func setTitle(_ title: String)
    func setChartView(_ chartView: UIView)
}

/// Chart view output
protocol ChartViewOutput: AnyObject {
    func setupView()
}
