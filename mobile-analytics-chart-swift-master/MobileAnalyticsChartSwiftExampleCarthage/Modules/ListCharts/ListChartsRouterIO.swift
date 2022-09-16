import UIKit

protocol ListChartsRouterInput: AnyObject {
    func openChartModule(
        inputData: AnalyticsChartViewModel
    )

    func openCustomChartModule(
        inputData: AnalyticsChartViewModel
    )

    func openMultiselectChartsModule(
        inputData: AnalyticsChartViewModel
    )
}
