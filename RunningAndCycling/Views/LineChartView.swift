
//  LineChartView.swift
//  RunningAndCycling
//
//  Created by lion on 23.02.22.





import UIKit

@IBDesignable
final class LineChartView: UIView {
    
    var graphPoints = [ 4.2 , 2.2 , 6.2 , 4.2 , 5.2 , 8.2 , 3.2 ]
    
    
    private enum Constants {
        static let cornerRadiusSize = CGSize(width: 8.0, height: 8.0)
        static let margin: CGFloat = 10.0
        static let topBorder: CGFloat = 20.0
        static let bottomBorder: CGFloat = 0.0
        static let colorAlpha: CGFloat = 0.3
        static let circleDiameter: CGFloat = 5.0
    }
    
    
    // 1
    @IBInspectable var startColor: UIColor = .darkGray
    @IBInspectable var endColor: UIColor = .lightGray
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: .allCorners,
            cornerRadii: Constants.cornerRadiusSize
        )
        path.addClip()
        
        let width = rect.width
        let height = rect.height
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        let colors = [startColor.cgColor, endColor.cgColor]
        
        // 3
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 4
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        // 5
        guard let gradient = CGGradient(
            colorsSpace: colorSpace,
            colors: colors as CFArray,
            locations: colorLocations
        ) else {
            return
        }
        
        // 6
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(
            gradient,
            start: startPoint,
            end: endPoint,
            options: []
        )
        // Calculate the x point
        
        let margin = Constants.margin
        let graphWidth = width - margin * 2 - 4
        let columnXPoint = { (column: Int) -> CGFloat in
            // Вычислить разрыв между точками
            let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
            return CGFloat(column) * spacing + margin + 2
        }
        
        // Calculate the y point
        
        let topBorder = Constants.topBorder
        let bottomBorder = Constants.bottomBorder
        let graphHeight = height - topBorder - bottomBorder
        guard let maxValue = graphPoints.max() else {
            return
        }
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            let yPoint = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            return graphHeight + topBorder - yPoint // Flip the graph
        }
        
        // Draw the line graph
        
        UIColor.white.setFill()
        UIColor.white.setStroke()
        
        // Set up the points line
        let graphPath = UIBezierPath()
        
        // Go to start of line
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(Int(graphPoints[0]))))
        
        // Add points for each item in the graphPoints array
        // at the correct (x, y) for the point
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(Int(graphPoints[i])))
            graphPath.addLine(to: nextPoint)
        }
        
        // Create the clipping path for the graph gradient
        
        // 1 - Save the state of the context (commented out for now)
        context.saveGState()
        
        // 2 - Make a copy of the path
        guard let clippingPath = graphPath.copy() as? UIBezierPath else {
            return
        }
        
        // 3 - Add lines to the copied path to complete the clip area
        clippingPath.addLine(to: CGPoint(
            x: columnXPoint(graphPoints.count - 1),
            y: height))
        clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y: height))
        clippingPath.close()
        
        // 4 - Add the clipping path to the context
        clippingPath.addClip()
        
        // 5 - Check clipping path - Temporary code
        let highestYPoint = columnYPoint(Int(maxValue))
        let graphStartPoint = CGPoint(x: margin, y: highestYPoint)
        let graphEndPoint = CGPoint(x: margin, y: bounds.height)
        
        context.drawLinearGradient(
            gradient,
            start: graphStartPoint,
            end: graphEndPoint,
            options: [])
        context.restoreGState()
        
        // End temporary code
        // Рисуем линию поверх обрезанного градиента
        graphPath.lineWidth =  2.0
        graphPath.stroke()
        
        // Draw horizontal graph lines on the top of everything
        let linePath = UIBezierPath()
        
        // Top line
        linePath.move(to: CGPoint(x: margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: topBorder))
        
        // Center line
        linePath.move(to: CGPoint(x: margin, y: graphHeight / 2 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight / 2 + topBorder))
        
        // Bottom line
        linePath.move(to: CGPoint(x: margin, y: height - bottomBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: Constants.colorAlpha)
        color.setStroke()
        
        linePath.lineWidth = 1.0
        linePath.stroke()
        
        
    }
}





//import UIKit
//
//struct PointEntry {
//    let value: Int
//    let label: String
//}
//
//extension PointEntry: Comparable {
//    static func <(lhs: PointEntry, rhs: PointEntry) -> Bool {
//        return lhs.value < rhs.value
//    }
//    static func ==(lhs: PointEntry, rhs: PointEntry) -> Bool {
//        return lhs.value == rhs.value
//    }
//}
//
//class LineChartView: UIView {
//
//    /// gap between each point
//    let lineGap: CGFloat = 60.0
//
//    /// preseved space at top of the chart
//    let topSpace: CGFloat = 40.0
//
//    /// preserved space at bottom of the chart to show labels along the Y axis
//    let bottomSpace: CGFloat = 40.0
//
//    /// The top most horizontal line in the chart will be 10% higher than the highest value in the chart
//    let topHorizontalLine: CGFloat = 110.0 / 100.0
//
//    var isCurved: Bool = false
//
//    /// Active or desactive animation on dots
//    var animateDots: Bool = false
//
//    /// Active or desactive dots
//    var showDots: Bool = false
//
//    /// Dot inner Radius
//    var innerRadius: CGFloat = 8
//
//    /// Dot outer Radius
//    var outerRadius: CGFloat = 12
//
//    var dataEntries: [PointEntry]? {
//        didSet {
//            self.setNeedsLayout()
//        }
//    }
//
//    /// Contains the main line which represents the data
//    private let dataLayer: CALayer = CALayer()
//
//    /// To show the gradient below the main line
//    private let gradientLayer: CAGradientLayer = CAGradientLayer()
//
//    /// Contains dataLayer and gradientLayer
//    private let mainLayer: CALayer = CALayer()
//
//    /// Contains mainLayer and label for each data entry
//    private let scrollView: UIScrollView = UIScrollView()
//
//    /// Contains horizontal lines
//    private let gridLayer: CALayer = CALayer()
//
//    /// An array of CGPoint on dataLayer coordinate system that the main line will go through. These points will be calculated from dataEntries array
//    private var dataPoints: [CGPoint]?
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//
//    convenience init() {
//        self.init(frame: CGRect.zero)
//        setupView()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupView()
//    }
//
//    private func setupView() {
//        mainLayer.addSublayer(dataLayer)
//        scrollView.layer.addSublayer(mainLayer)
//
//        gradientLayer.colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor, UIColor.clear.cgColor]
//        scrollView.layer.addSublayer(gradientLayer)
//        self.layer.addSublayer(gridLayer)
//        self.addSubview(scrollView)
//        self.backgroundColor = #colorLiteral(red: 0, green: 0.3529411765, blue: 0.6156862745, alpha: 1)
//    }
//
//    override func layoutSubviews() {
//        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
//        if let dataEntries = dataEntries {
//            scrollView.contentSize = CGSize(width: CGFloat(dataEntries.count) * lineGap, height: self.frame.size.height)
//            mainLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(dataEntries.count) * lineGap, height: self.frame.size.height)
//            dataLayer.frame = CGRect(x: 0, y: topSpace, width: mainLayer.frame.width, height: mainLayer.frame.height - topSpace - bottomSpace)
//            gradientLayer.frame = dataLayer.frame
//            dataPoints = convertDataEntriesToPoints(entries: dataEntries)
//            gridLayer.frame = CGRect(x: 0, y: topSpace, width: self.frame.width, height: mainLayer.frame.height - topSpace - bottomSpace)
//            if showDots { drawDots() }
//            clean()
//            drawHorizontalLines()
//            if isCurved {
//                drawCurvedChart()
//            } else {
//                drawChart()
//            }
//            maskGradientLayer()
//            drawLables()
//        }
//    }
//
//    /**
//     Convert an array of PointEntry to an array of CGPoint on dataLayer coordinate system
//     */
//    private func convertDataEntriesToPoints(entries: [PointEntry]) -> [CGPoint] {
//        if let max = entries.max()?.value,
//            let min = entries.min()?.value {
//
//            var result: [CGPoint] = []
//            let minMaxRange: CGFloat = CGFloat(max - min) * topHorizontalLine
//
//            for i in 0..<entries.count {
//                let height = dataLayer.frame.height * (1 - ((CGFloat(entries[i].value) - CGFloat(min)) / minMaxRange))
//                let point = CGPoint(x: CGFloat(i)*lineGap + 40, y: height)
//                result.append(point)
//            }
//            return result
//        }
//        return []
//    }
//
//    /**
//     Draw a zigzag line connecting all points in dataPoints
//     */
//    private func drawChart() {
//        if let dataPoints = dataPoints,
//            dataPoints.count > 0,
//            let path = createPath() {
//
//            let lineLayer = CAShapeLayer()
//            lineLayer.path = path.cgPath
//            lineLayer.strokeColor = UIColor.white.cgColor
//            lineLayer.fillColor = UIColor.clear.cgColor
//            dataLayer.addSublayer(lineLayer)
//        }
//    }
//
//    /**
//     Create a zigzag bezier path that connects all points in dataPoints
//     */
//    private func createPath() -> UIBezierPath? {
//        guard let dataPoints = dataPoints, dataPoints.count > 0 else {
//            return nil
//        }
//        let path = UIBezierPath()
//        path.move(to: dataPoints[0])
//
//        for i in 1..<dataPoints.count {
//            path.addLine(to: dataPoints[i])
//        }
//        return path
//    }
//
//    /**
//     Draw a curved line connecting all points in dataPoints
//     */
//    private func drawCurvedChart() {
//        guard let dataPoints = dataPoints, dataPoints.count > 0 else {
//            return
//        }
//        if let path = CurveAlgorithm.shared.createCurvedPath(dataPoints) {
//            let lineLayer = CAShapeLayer()
//            lineLayer.path = path.cgPath
//            lineLayer.strokeColor = UIColor.white.cgColor
//            lineLayer.fillColor = UIColor.clear.cgColor
//            dataLayer.addSublayer(lineLayer)
//        }
//    }
//
//    /**
//     Create a gradient layer below the line that connecting all dataPoints
//     */
//    private func maskGradientLayer() {
//        if let dataPoints = dataPoints,
//            dataPoints.count > 0 {
//
//            let path = UIBezierPath()
//            path.move(to: CGPoint(x: dataPoints[0].x, y: dataLayer.frame.height))
//            path.addLine(to: dataPoints[0])
//            if isCurved,
//                let curvedPath = CurveAlgorithm.shared.createCurvedPath(dataPoints) {
//                path.append(curvedPath)
//            } else if let straightPath = createPath() {
//                path.append(straightPath)
//            }
//            path.addLine(to: CGPoint(x: dataPoints[dataPoints.count-1].x, y: dataLayer.frame.height))
//            path.addLine(to: CGPoint(x: dataPoints[0].x, y: dataLayer.frame.height))
//
//            let maskLayer = CAShapeLayer()
//            maskLayer.path = path.cgPath
//            maskLayer.fillColor = UIColor.white.cgColor
//            maskLayer.strokeColor = UIColor.clear.cgColor
//            maskLayer.lineWidth = 0.0
//
//            gradientLayer.mask = maskLayer
//        }
//    }
//
//    /**
//     Create titles at the bottom for all entries showed in the chart
//     */
//    private func drawLables() {
//        if let dataEntries = dataEntries,
//            dataEntries.count > 0 {
//            for i in 0..<dataEntries.count {
//                let textLayer = CATextLayer()
//                textLayer.frame = CGRect(x: lineGap*CGFloat(i) - lineGap/2 + 40, y: mainLayer.frame.size.height - bottomSpace/2 - 8, width: lineGap, height: 16)
//                textLayer.foregroundColor = #colorLiteral(red: 0.5019607843, green: 0.6784313725, blue: 0.8078431373, alpha: 1).cgColor
//                textLayer.backgroundColor = UIColor.clear.cgColor
//                textLayer.alignmentMode = CATextLayerAlignmentMode.center
//                textLayer.contentsScale = UIScreen.main.scale
//                textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
//                textLayer.fontSize = 11
//                textLayer.string = dataEntries[i].label
//                mainLayer.addSublayer(textLayer)
//            }
//        }
//    }
//
//    /**
//     Create horizontal lines (grid lines) and show the value of each line
//     */
//    private func drawHorizontalLines() {
//        guard let dataEntries = dataEntries else {
//            return
//        }
//
//        var gridValues: [CGFloat]? = nil
//        if dataEntries.count < 4 && dataEntries.count > 0 {
//            gridValues = [0, 1]
//        } else if dataEntries.count >= 4 {
//            gridValues = [0, 0.25, 0.5, 0.75, 1]
//        }
//        if let gridValues = gridValues {
//            for value in gridValues {
//                let height = value * gridLayer.frame.size.height
//
//                let path = UIBezierPath()
//                path.move(to: CGPoint(x: 0, y: height))
//                path.addLine(to: CGPoint(x: gridLayer.frame.size.width, y: height))
//
//                let lineLayer = CAShapeLayer()
//                lineLayer.path = path.cgPath
//                lineLayer.fillColor = UIColor.clear.cgColor
//                lineLayer.strokeColor = #colorLiteral(red: 0.2784313725, green: 0.5411764706, blue: 0.7333333333, alpha: 1).cgColor
//                lineLayer.lineWidth = 0.5
//                if (value > 0.0 && value < 1.0) {
//                    lineLayer.lineDashPattern = [4, 4]
//                }
//
//                gridLayer.addSublayer(lineLayer)
//
//                var minMaxGap:CGFloat = 0
//                var lineValue:Int = 0
//                if let max = dataEntries.max()?.value,
//                    let min = dataEntries.min()?.value {
//                    minMaxGap = CGFloat(max - min) * topHorizontalLine
//                    lineValue = Int((1-value) * minMaxGap) + Int(min)
//                }
//
//                let textLayer = CATextLayer()
//                textLayer.frame = CGRect(x: 4, y: height, width: 50, height: 16)
//                textLayer.foregroundColor = #colorLiteral(red: 0.5019607843, green: 0.6784313725, blue: 0.8078431373, alpha: 1).cgColor
//                textLayer.backgroundColor = UIColor.clear.cgColor
//                textLayer.contentsScale = UIScreen.main.scale
//                textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
//                textLayer.fontSize = 12
//                textLayer.string = "\(lineValue)"
//
//                gridLayer.addSublayer(textLayer)
//            }
//        }
//    }
//
//    private func clean() {
//        mainLayer.sublayers?.forEach({
//            if $0 is CATextLayer {
//                $0.removeFromSuperlayer()
//            }
//        })
//        dataLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
//        gridLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
//    }
//    /**
//     Create Dots on line points
//     */
//    private func drawDots() {
//        var dotLayers: [DotCALayer] = []
//        if let dataPoints = dataPoints {
//            for dataPoint in dataPoints {
//                let xValue = dataPoint.x - outerRadius/2
//                let yValue = (dataPoint.y + lineGap) - (outerRadius * 2)
//                let dotLayer = DotCALayer()
//                dotLayer.dotInnerColor = UIColor.white
//                dotLayer.innerRadius = innerRadius
//                dotLayer.backgroundColor = UIColor.white.cgColor
//                dotLayer.cornerRadius = outerRadius / 2
//                dotLayer.frame = CGRect(x: xValue, y: yValue, width: outerRadius, height: outerRadius)
//                dotLayers.append(dotLayer)
//
//                mainLayer.addSublayer(dotLayer)
//
//                if animateDots {
//                    let anim = CABasicAnimation(keyPath: "opacity")
//                    anim.duration = 1.0
//                    anim.fromValue = 0
//                    anim.toValue = 1
//                    dotLayer.add(anim, forKey: "opacity")
//                }
//            }
//        }
//    }
//}
//

// отдельным файлом

//class DotCALayer: CALayer {
//
//    var innerRadius: CGFloat = 8
//    var dotInnerColor = UIColor.black
//
//    override init() {
//        super.init()
//    }
//
//    override init(layer: Any) {
//        super.init(layer: layer)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    override func layoutSublayers() {
//        super.layoutSublayers()
//        let inset = self.bounds.size.width - innerRadius
//        let innerDotLayer = CALayer()
//        innerDotLayer.frame = self.bounds.insetBy(dx: inset/2, dy: inset/2)
//        innerDotLayer.backgroundColor = dotInnerColor.cgColor
//        innerDotLayer.cornerRadius = innerRadius / 2
//        self.addSublayer(innerDotLayer)
//    }
//
//}
//
//
//  отдельним файлом

//struct CurvedSegment {
//    var controlPoint1: CGPoint
//    var controlPoint2: CGPoint
//}
//
//class CurveAlgorithm {
//    static let shared = CurveAlgorithm()
//
//    private func controlPointsFrom(points: [CGPoint]) -> [CurvedSegment] {
//        var result: [CurvedSegment] = []
//
//        let delta: CGFloat = 0.3 // The value that help to choose temporary control points.
//
//        // Calculate temporary control points, these control points make Bezier segments look straight and not curving at all
//        for i in 1..<points.count {
//            let A = points[i-1]
//            let B = points[i]
//            let controlPoint1 = CGPoint(x: A.x + delta*(B.x-A.x), y: A.y + delta*(B.y - A.y))
//            let controlPoint2 = CGPoint(x: B.x - delta*(B.x-A.x), y: B.y - delta*(B.y - A.y))
//            let curvedSegment = CurvedSegment(controlPoint1: controlPoint1, controlPoint2: controlPoint2)
//            result.append(curvedSegment)
//        }
//
//        // Calculate good control points
//        for i in 1..<points.count-1 {
//            /// A temporary control point
//            let M = result[i-1].controlPoint2
//
//            /// A temporary control point
//            let N = result[i].controlPoint1
//
//            /// central point
//            let A = points[i]
//
//            /// Reflection of M over the point A
//            let MM = CGPoint(x: 2 * A.x - M.x, y: 2 * A.y - M.y)
//
//            /// Reflection of N over the point A
//            let NN = CGPoint(x: 2 * A.x - N.x, y: 2 * A.y - N.y)
//
//            result[i].controlPoint1 = CGPoint(x: (MM.x + N.x)/2, y: (MM.y + N.y)/2)
//            result[i-1].controlPoint2 = CGPoint(x: (NN.x + M.x)/2, y: (NN.y + M.y)/2)
//        }
//
//        return result
//    }
//
//    /**
//     Create a curved bezier path that connects all points in the dataset
//     */
//    func createCurvedPath(_ dataPoints: [CGPoint]) -> UIBezierPath? {
//        let path = UIBezierPath()
//        path.move(to: dataPoints[0])
//
//        var curveSegments: [CurvedSegment] = []
//        curveSegments = controlPointsFrom(points: dataPoints)
//
//        for i in 1..<dataPoints.count {
//            path.addCurve(to: dataPoints[i], controlPoint1: curveSegments[i-1].controlPoint1, controlPoint2: curveSegments[i-1].controlPoint2)
//        }
//        return path
//    }
//}


//эти методы в контроллер где лежит вьюха графика

// метод setGraf() во viewDidLoad()

//    private func setGraf() {
//        let dataEntries = generateRandomEntries()
//        runPaceChart.dataEntries = dataEntries
//        runPaceChart.isCurved = true
//    }
//
//    private func generateRandomEntries() -> [PointEntry] {
//        var result: [PointEntry] = []
//        for i in 0..<100 {
//            let value = Int(arc4random() % 500)
//
//            let formatter = DateFormatter()
//            formatter.dateFormat = "d MMM"
//            var date = Date()
//            date.addTimeInterval(TimeInterval(24*60*60*i))
//
//            result.append(PointEntry(value: value, label: formatter.string(from: date)))
//        }
//        return result
//    }
