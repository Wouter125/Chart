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
public enum LineType {
    case bezier
    case linear
}

// MARK: - Touch Tracker
public struct TouchTrackerData {
    var touchCoords: CGPoint
    var lineCoords: CGPoint
    var data: CGPoint
    
    public init(touchCoords: CGPoint, lineCoords: CGPoint, data: CGPoint) {
        self.touchCoords = touchCoords
        self.lineCoords = lineCoords
        self.data = data
    }
}

// MARK: - Axes
public struct xAxis {
    var isHidden: Bool
    var count: Int?
    var labels: [String]?
    
    public init(isHidden: Bool, count: Int? = nil, labels: [String]? = nil) {
        self.isHidden = isHidden
        self.count = count
        self.labels = labels
    }
}

public struct yAxis {
    var isHidden: Bool
    var count: Int?
    
    public init(isHidden: Bool, count: Int? = nil) {
        self.isHidden = isHidden
        self.count = count
    }
}

public struct AxesConfiguration {
    var x: xAxis
    var y: yAxis
    var color: CGColor
    var width: CGFloat
    var labelColor: CGColor
    
    public init(x: xAxis, y: yAxis, color: CGColor, width: CGFloat, labelColor: CGColor) {
        self.x = x
        self.y = y
        self.color = color
        self.width = width
        self.labelColor = labelColor
    }
}

#endif
