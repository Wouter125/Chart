#if canImport(UIKit)
import UIKit

public protocol LineChartDelegate: class {
    func didBeginPanning(_ lineChart: LineChart, _ result: TouchTrackerData)
    func didEndPanning(_ lineChart: LineChart, _ result: TouchTrackerData)
}

extension LineChartDelegate {
    func didBeginPanning(_ lineChart: LineChart, _ result: TouchTrackerData) {}
    func didEndPanning(_ lineChart: LineChart, _ result: TouchTrackerData) {}
}

public class LineChart: UIView {
    // MARK: - Data
    open var data: [CGPoint]? {
        didSet {
            if let data = data, data.count >= 2 {
                // TODO: <Wouter> find a better way to deal with an offset in data
                self.offset = data[0].x
                self.data = data.enumerated().map { (index, point) -> CGPoint in
                    return CGPoint(x: point.x - data[0].x, y: point.y)
                }
                
                configureChart()
            } else {
                print("Chart View Error: Number of data points must be greater than or equal to 2.")
            }
        }
    }
    
    // MARK: - Graph
    open var inset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    // MARK: - Axes
    open var axesConfiguration: AxesConfiguration = AxesConfiguration(
        x: xAxis(isHidden: true, count: nil),
        y: yAxis(isHidden: true, count: nil),
        color: UIColor.systemGray5.cgColor,
        width: 1.0,
        labelColor: UIColor.systemGray.cgColor
    )
    
    // MARK: - Line
    open var lineType: LineType = .linear
    open var lineColor: CGColor = UIColor.systemGreen.cgColor
    open var lineWidth: CGFloat = 2.0
    
    // MARK: - Line Background
    open var showBackground: Bool = true
    open var backgroundColors: [CGColor] = [UIColor.systemGreen.withAlphaComponent(0.24).cgColor, UIColor.systemGreen.withAlphaComponent(0).cgColor]
    
    // MARK: - Line Points
    open var showPoints: Bool = false
    open var pointsFillColor: CGColor = UIColor.white.cgColor
    open var pointsStrokeColor: CGColor = UIColor.systemGreen.cgColor
    open var pointsStrokeWidth: CGFloat = 2.0
    
    // MARK: - Animation
    open var isAnimated: Bool = false
    open var animationCurve: CAMediaTimingFunction = CAMediaTimingFunction.easeInOutCubic
    open var animationDuration: Double = 0.8
    
    // MARK: - Touch Tracking
    open var isTouchTrackingEnabled: Bool = true
    
    // MARK: - Delegate
    open weak var delegate: LineChartDelegate?
    
    // MARK: - Init
    fileprivate var offset: CGFloat = 0
    
    fileprivate var lineLayer = LineLayer()
    fileprivate var pointsLayer = LinePointsLayer()
    fileprivate var backgroundLayer = LineBackgroundLayer()
    fileprivate var backgroundMaskLayer = CAShapeLayer()
    fileprivate var axesLayer = AxesLayer()
    
    fileprivate var touchTracker: TouchTracker?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        self.layer.sublayers?.removeAll()
        
        lineLayer = LineLayer(strokeColor: lineColor, lineWidth: lineWidth)
        pointsLayer = LinePointsLayer(fillColor: pointsFillColor, strokeColor: pointsStrokeColor, strokeWidth: pointsStrokeWidth)
        backgroundLayer = LineBackgroundLayer(colors: backgroundColors)
        axesLayer = AxesLayer(frame: frame, inset: inset, configuration: axesConfiguration)
        
        backgroundLayer.mask = backgroundMaskLayer
        backgroundLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        self.layer.addSublayer(axesLayer)
        self.layer.addSublayer(backgroundLayer)
        self.layer.addSublayer(lineLayer)
        self.layer.addSublayer(pointsLayer)
        
        configureChart()
    }
    
    private func configureChart() {
        guard let data = data else { return }

        let transform = PathTransformer(bounds: bounds, data: data, inset: inset).getTransform()
        let pathBuilder = PathBuilder(data: data, transform: transform)
        let pathAnimator = PathAnimator(animationDuration: animationDuration, timingFunction: animationCurve)
        
        let linePath = pathBuilder.drawLinePath(type: lineType)
        let pointsPath = pathBuilder.drawPointsPath()
        let backgroundPath = pathBuilder.drawLineBackgroundPath()
        
        if isAnimated {
            pathAnimator.addPathAnimation(to: lineLayer, path: linePath)
            if showPoints { pathAnimator.addPathAnimation(to: pointsLayer, path: pointsPath) }
            if showBackground { pathAnimator.addPathAnimation(to: backgroundMaskLayer, path: backgroundPath) }
        } else {
            lineLayer.path = linePath
            if showPoints { pointsLayer.path = pointsPath }
            if showBackground { backgroundMaskLayer.path = backgroundPath }
        }
        
        if !axesConfiguration.x.isHidden || !axesConfiguration.y.isHidden {
            axesLayer.drawAxes(pathBuilder: pathBuilder, configuration: axesConfiguration, data: data, offset: offset)
        }
        
        if isTouchTrackingEnabled {
            touchTracker = TouchTracker(frame: frame, inset: inset, points: data, chartMap: transform, offset: offset)
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(recognizer:)))
            self.addGestureRecognizer(panGesture)
        }
    }
    
    @objc func didPan(recognizer: UIPanGestureRecognizer) {
        let touchPoint = recognizer.location(in: recognizer.view)

        if let touchTrackerData = touchTracker?.getData(at: touchPoint, with: lineType) {
            switch recognizer.state {
            case .began, .changed:
                if touchPoint.x < inset.left || touchPoint.x > (self.bounds.width - inset.right) { return }
                delegate?.didBeginPanning(self, touchTrackerData)
            case .ended:
                delegate?.didEndPanning(self, touchTrackerData)
            default: break
            }
        }
    }
}
#endif
