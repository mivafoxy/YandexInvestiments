import SpriteKit

/// AnalyticsChartSpriteKit view input
protocol AnalyticsChartSpriteKitViewInput: AnyObject {
    func setScene(scene: SKScene)
}

/// AnalyticsChartSpriteKit view output
protocol AnalyticsChartSpriteKitViewOutput: AnyObject {
    func setupView()

    func redraw()

    func traitCollectionDidChange()
}
