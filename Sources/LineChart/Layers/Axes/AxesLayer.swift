//
//  AxesLayer.swift
//  
//
//  Created by Wouter van de Kamp on 17/05/2020.
//

#if canImport(UIKit)
import UIKit

class AxesLayer: CAShapeLayer {
    private var configuration: AxesConfiguration!
    
    override init() {
        super.init()
    }
    
    init(frame: CGRect, inset: UIEdgeInsets, configuration: AxesConfiguration) {
        super.init()
        
        self.frame = CGRect(
            x: inset.left,
            y: inset.top,
            width: frame.width - inset.right - inset.left,
            height: frame.height - inset.bottom
        )
        
        self.configuration = configuration
        
        configureLayer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayer() {
        self.strokeColor = configuration.color
        self.lineWidth = configuration.width
        self.lineDashPattern = [2, 4]
    }
    
    public func drawAxes(pathBuilder: PathBuilder, configuration: AxesConfiguration, data: [CGPoint], offset: CGFloat) {
        self.sublayers?.removeAll()
        
        self.configuration = configuration
        
        if self.configuration.x.count == nil {
            self.configuration.x.count = data.count - 1
        }
        
        if self.configuration.y.count == nil {
            self.configuration.y.count = data.count - 1
        }
        
        drawAxesPath(pathBuilder: pathBuilder, frame: frame)
        drawXLabels(frame: frame, data: data, offset: offset)
        drawYLabels(frame: frame, data: data)
    }
    
    private func drawAxesPath(pathBuilder: PathBuilder, frame: CGRect) {
        let axesPath = pathBuilder.drawAxesPath(configuration: configuration, frame: frame)
        self.path = axesPath
    }
    
    private func drawXLabels(frame: CGRect, data: [CGPoint], offset: CGFloat) {
        var step: CGFloat = 0.0
        let dataStep = (data.last!.x) / CGFloat(configuration.x.count!)
                
        if configuration.x.labels != nil {
            step = frame.width / CGFloat(configuration.x.labels!.count - 1)
            
            for index in 0..<configuration.x.labels!.count {
                let xLabel = AxesLabelLayer(foregroundColor: configuration.labelColor)
                xLabel.frame = CGRect(x: (step * CGFloat(index)) - (step / 2), y: frame.height + 8, width: step, height: 24)
                xLabel.string = configuration.x.labels![index]
                self.addSublayer(xLabel)
            }
        } else {
            step = frame.width / CGFloat(configuration.x.count!)
            
            for index in 0...configuration.x.count! {
                let xLabel = AxesLabelLayer(foregroundColor: configuration.labelColor)
                xLabel.frame = CGRect(x: (step * CGFloat(index)) - (step / 2), y: frame.height + 8, width: step, height: 24)
                xLabel.string = String(format: "%.02f", (CGFloat(index) * dataStep) + offset)
                self.addSublayer(xLabel)
            }
        }
    }
    
    private func drawYLabels(frame: CGRect, data: [CGPoint]) {
        let step = frame.height / CGFloat(configuration.y.count!)
        let dataStep = data.min{ $1.y < $0.y }!.y / CGFloat(configuration.y.count!)
        
        for index in stride(from: configuration.y.count! - 1, through: 0, by: -1) {
            let yLabel = AxesLabelLayer(foregroundColor: configuration.labelColor)
            yLabel.frame = CGRect(x: -48.0, y: (CGFloat((configuration.y.count! - 1) - index) * step) - 8, width: 40, height: 24)
            yLabel.alignmentMode = .right
            yLabel.string = "\((Int(CGFloat(index + 1) * dataStep)))"
            self.addSublayer(yLabel)
        }
    }
}
#endif
