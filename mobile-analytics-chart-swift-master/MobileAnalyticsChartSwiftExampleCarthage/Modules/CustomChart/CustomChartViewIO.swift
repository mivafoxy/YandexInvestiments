import UIKit

/// CustomChart view input
protocol CustomChartViewInput: AnyObject {
    func setTitle(_ title: String)
    func setChartView(_ chartView: UIView)
}

/// CustomChart view output
protocol CustomChartViewOutput: AnyObject {
    func setupView()
    func didPressSetChartButton()
    func didPressSetChartSilentButton()
    func didPressSetLoadingStateButton()
    func didPressSetIdleStateButton()
}
