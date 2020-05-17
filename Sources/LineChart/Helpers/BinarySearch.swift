//
//  BinarySearch.swift
//  
//
//  Created by Wouter van de Kamp on 17/05/2020.
//

#if canImport(UIKit)
import UIKit

class BinarySearch {
    static func search(in points: [CGPoint], for touchPoint: CGPoint) -> (first: Int, second: Int) {
        var lower = 0
        var upper = points.count - 1
        var middle = (lower + upper) / 2

        while upper - lower > 1 {
            middle = (lower + upper) / 2
            
            if points[middle].x < touchPoint.x {
                lower = middle
            } else {
                upper = middle
            }
        }
        
        return (first: lower, second: upper)
    }
}
#endif
