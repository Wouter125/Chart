//
//  BezierControlPointsCalculator.swift
//  
//
//  Created by Wouter van de Kamp on 17/05/2020.
//

#if canImport(UIKit)
import UIKit

class BezierControlPointsCalculator {
    static func calculate(from points: [CGFloat]) -> (cp1: [CGFloat], cp2: [CGFloat]) {
        let n = points.count - 1
        
        var cp1 = Array(repeating: CGFloat(), count: n)
        var cp2 = Array(repeating: CGFloat(), count: n)
        
        var a = [CGFloat]()
        var b = [CGFloat]()
        var c = [CGFloat]()
        var r = [CGFloat]()
        
        /// First point on the left
        a.append(0)
        b.append(2)
        c.append(1)
        r.append(points[0] + 2 * points[1])
        
        /// Points between first and last point
        for index in 1..<n {
            a.append(1)
            b.append(4)
            c.append(1)
            r.append(4 * points[index] + 2 * points[index + 1])
        }
        
        /// Last point on the right
        a[n - 1] = 2
        b[n - 1] = 7
        c[n - 1] = 0
        r[n - 1] = 8 * points[n - 1] + points[n]

        /// Solves ax = b with the Thomas Algorithm
        for index in 1..<n {
            let m = a[index] / b[index - 1]
            b[index] = b[index] - m * c[index - 1]
            r[index] = r[index] - m * r[index - 1]
        }

        cp1[n - 1] = r[n - 1] / b[n - 1]
        
        for index in stride(from: n - 2, through: 0, by: -1) {
            cp1[index] = (r[index] - c[index] * cp1[index + 1]) / b[index]
        }
        
        for index in 0..<n - 1 {
            cp2[index] = 2 * points[index + 1] - cp1[index + 1]
        }
        
        cp2[n - 1] = 0.5 * (points[n] + cp1[n - 1])
        
        return (cp1: cp1, cp2: cp2)
    }
}

#endif
