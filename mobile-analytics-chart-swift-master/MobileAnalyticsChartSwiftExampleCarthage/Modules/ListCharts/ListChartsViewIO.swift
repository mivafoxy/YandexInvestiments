import Foundation

/// ListCharts view input
protocol ListChartsViewInput: AnyObject {
    func reloadData()
}

/// ListCharts view output
protocol ListChartsViewOutput: AnyObject {
    func setupView()
    func numberOfRows() -> Int
    func titleForRow(at indexPath: IndexPath) -> String
    func didSelect(at indexPath: IndexPath)
}
