//
//  LineData.swift
//  LineGraph
//
//  Created by Wouter van de Kamp on 05/05/2020.
//  Copyright © 2020 Wouter van de Kamp. All rights reserved.
//

#if canImport(UIKit)
import UIKit

// MARK: - Line
enum LineType {
    case bezier
    case linear
}

// MARK: - Touch Tracker
struct TouchTrackerData {
    var touchCoords: CGPoint
    var lineCoords: CGPoint
    var data: CGPoint
}


// MARK: - Axes
struct xAxis {
    var isHidden: Bool
    var count: Int?
    var labels: [String]?
    
    init(isHidden: Bool, count: Int? = nil, labels: [String]? = nil) {
        self.isHidden = isHidden
        self.count = count
        self.labels = labels
    }
}

struct yAxis {
    var isHidden: Bool
    var count: Int?
    
    init(isHidden: Bool, count: Int? = nil) {
        self.isHidden = isHidden
        self.count = count
    }
}

struct AxesConfiguration {
    var x: xAxis
    var y: yAxis
    var color: CGColor
    var width: CGFloat
    var labelColor: CGColor
}

#endif
