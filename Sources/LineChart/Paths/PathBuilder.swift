//
//  PathBuilder.swift
//  
//
//  Created by Wouter van de Kamp on 17/05/2020.
//

#if canImport(UIKit)
import UIKit

class PathBuilder {
    private var data: [CGPoint]
    private var transform: CGAffineTransform
    
    private var path: CGMutablePath!
    
    init(data: [CGPoint], transform: CGAffineTransform) {
        self.data = data
        self.transform = transform
    }
    
    public func drawLinePath(type: LineType) -> CGMutablePath {
        path = CGMutablePath()
        
        switch type {
        case .linear:
            path = drawLinearLinePath()
        case .bezier:
            path = drawBezierLinePath()
        }
        
        return path
    }
    
    private func drawLinearLinePath() -> CGMutablePath {
        let path = CGMutablePath()
        path.addLines(between: data, transform: transform)
        
        return path
    }
    
    private func drawBezierLinePath() -> CGMutablePath {
        let xControlPoints = BezierControlPointsCalculator.calculate(from: data.map { $0.x })
        let yControlPoints = BezierControlPointsCalculator.calculate(from: data.map { $0.y })
        
        let path = CGMutablePath()
        path.move(to: data[0], transform: transform)
        
        for (index, _) in data.enumerated() {
            if (index + 1) < data.count {
                path.addCurve(
                    to: data[index + 1],
                    control1: CGPoint(x: xControlPoints.cp1[index], y: yControlPoints.cp1[index]),
                    control2: CGPoint(x: xControlPoints.cp2[index], y: yControlPoints.cp2[index]),
                    transform: transform
                )
            }
        }
        
        return path
    }
    
    public func drawLineBackgroundPath() -> CGMutablePath {
        let backgroundPath = path.mutableCopy()!
        backgroundPath.addLine(to: CGPoint(x: data[data.count - 1].x, y: 0), transform: transform)
        backgroundPath.addLine(to: CGPoint(x: 0, y: 0), transform: transform)
        backgroundPath.closeSubpath()
        
        return backgroundPath
    }
    
    public func drawPointsPath() -> CGMutablePath {
        let pointsPath = CGMutablePath()

        for point in data {
            let mappedPoint = point.applying(transform)
            let offset: CGFloat = 8 / 2
            let styledPoint = UIBezierPath(
                roundedRect: CGRect(
                    x: mappedPoint.x - offset,
                    y: mappedPoint.y - offset,
                    width: 8,
                    height: 8
                ),
                cornerRadius: offset
            )
            pointsPath.addPath(styledPoint.cgPath)
        }
        
        return pointsPath
    }
    
    public func drawAxesPath(configuration: AxesConfiguration, frame: CGRect) -> CGMutablePath {
        let axesPath = CGMutablePath()
        
        if !configuration.x.isHidden {
            if configuration.x.labels != nil {
                for index in 0..<configuration.x.labels!.count {
                    let x = CGFloat(index) * (frame.width / CGFloat(configuration.x.labels!.count - 1))
                    axesPath.addLines(between: [CGPoint(x: x, y: 0), CGPoint(x: x, y: frame.height)])
                }
            } else {
                for index in 0...configuration.x.count! {
                    let x = CGFloat(index) * (frame.width / CGFloat(configuration.x.count!))
                    axesPath.addLines(between: [CGPoint(x: x, y: 0), CGPoint(x: x, y: frame.height)])
                }
            }
        }
        
        if !configuration.y.isHidden {
            for index in 0...configuration.y.count! {
                let y = CGFloat(index) * (frame.height / CGFloat(configuration.y.count!))
                axesPath.addLines(between: [CGPoint(x: 0, y: y), CGPoint(x: frame.width, y: y)])
            }
        }

        return axesPath
    }
}
#endif
