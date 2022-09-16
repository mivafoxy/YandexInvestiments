public protocol RenderDrawer: AnyObject {

    func redraw()

    func drawChart()

    func drawXAxis()

    func drawYAxis()

    func drawYAxisLabels()

    func drawZeroLine()

    func drawRangeLabel()

    func drawDefinition()
}
