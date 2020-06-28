//
//  TouchTracker.swift
//  
//
//  Created by Wouter van de Kamp on 17/05/2020.
//

#if canImport(UIKit)
import UIKit

class TouchTracker: LineChart {
    private var offset: CGFloat!
    private var dataPoints: [CGPoint]!
    private var screenLocationPoints: [CGPoint]!
    private var yScreenControlPoints: (cp1: [CGFloat], cp2: [CGFloat])?
    
    init(frame: CGRect, inset: UIEdgeInsets, points: [CGPoint], chartMap: CGAffineTransform, offset: CGFloat) {
        super.init(frame: CGRect(
            x: inset.left,
            y: inset.top,
            width: frame.width - inset.right - inset.left,
            height: frame.height - inset.bottom
        ))
        
        self.dataPoints = points
        self.screenLocationPoints = points.map{ $0.applying(chartMap) }
        self.offset = offset
        
        calculateControlPoints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func calculateControlPoints() {
        yScreenControlPoints = BezierControlPointsCalculator.calculate(from: screenLocationPoints.map { $0.y })
    }
    
    public func getData(at touchPoint: CGPoint, with lineType: LineType) -> TouchTrackerData? {
        let nearbyPoints = BinarySearch.search(in: screenLocationPoints, for: touchPoint)
        
        let xValue = calculateXValues(at: touchPoint.x, nearbyPoints)
        var yValue: (data: CGFloat, coords: CGFloat) = (data: 0, coords: 0)
        
        switch lineType {
        case .bezier:
            let dataValue = calculateLinearYValues(at: touchPoint.x, nearbyPoints).data
            let coordsValue = calculateBezierYValues(at: touchPoint.x, nearbyPoints)
            yValue = (data: dataValue, coords: coordsValue)
        case .linear:
            yValue = calculateLinearYValues(at: touchPoint.x, nearbyPoints)
        }

        return TouchTrackerData(
            touchCoords: touchPoint,
            lineCoords: CGPoint(x: touchPoint.x, y: yValue.coords + super.frame.origin.y),
            data: CGPoint(x: xValue + offset, y: yValue.data)
        )
    }
    
    private func calculateXValues(at t: CGFloat, _ nearbyPoints: (first: Int, second: Int)) -> CGFloat {
        let xOldRange = [screenLocationPoints[nearbyPoints.first].x, screenLocationPoints[nearbyPoints.second].x]
        let xNewRange = [dataPoints[nearbyPoints.first].x, dataPoints[nearbyPoints.second].x]
        
        let xValue = CGFloat(t).modulate(from: xOldRange, to: xNewRange, limit: true)
        
        return xValue
    }
    
    private func calculateBezierYValues(at t: CGFloat, _ nearbyPoints: (first: Int, second: Int)) -> CGFloat {
        let tOldRange = [screenLocationPoints[nearbyPoints.first].x, screenLocationPoints[nearbyPoints.second].x]
        let tNewRange: [CGFloat] = [0, 1]
        let t = t.modulate(from: tOldRange, to: tNewRange, limit: true)
        
        let p1 = pow((1 - t), 3) * screenLocationPoints[nearbyPoints.first].y
        let p2 = 3 * pow((1 - t), 2) * t * yScreenControlPoints!.cp1[nearbyPoints.first]
        let p3 = 3 * (1 - t) * pow(t, 2) * yScreenControlPoints!.cp2[nearbyPoints.first]
        let p4 = pow(t, 3) * screenLocationPoints[nearbyPoints.second].y
        
        let result = p1 + p2 + p3 + p4
        
        return result
    }
    
    private func calculateLinearYValues(at t: CGFloat, _ nearbyPoints: (first: Int, second: Int)) -> (data: CGFloat, coords: CGFloat) {
        let deltaY = (screenLocationPoints[nearbyPoints.first].y - screenLocationPoints[nearbyPoints.second].y)
        let deltaX = (screenLocationPoints[nearbyPoints.first].x - screenLocationPoints[nearbyPoints.second].x)
        let coordsYValue = (deltaY / deltaX) * (t - screenLocationPoints[nearbyPoints.first].x) + screenLocationPoints[nearbyPoints.first].y
        
        let yOldRange = [screenLocationPoints[nearbyPoints.first].y, screenLocationPoints[nearbyPoints.second].y]
        let yNewRange = [dataPoints[nearbyPoints.first].y, dataPoints[nearbyPoints.second].y]
        
        let dataYValue = CGFloat(coordsYValue).modulate(from: yOldRange, to: yNewRange, limit: true)
        
        return (data: dataYValue, coords: coordsYValue)
    }
}
#endif
