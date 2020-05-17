//
//  LinePointsLayer.swift
//  
//
//  Created by Wouter van de Kamp on 17/05/2020.
//

#if canImport(UIKit)
import UIKit

class LinePointsLayer: CAShapeLayer {
    override init() {
        super.init()
    }
    
    init(fillColor: CGColor, strokeColor: CGColor, strokeWidth: CGFloat) {
        super.init()
        configureLayer(fillColor: fillColor, strokeColor: strokeColor, lineWidth: strokeWidth)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayer(fillColor: CGColor, strokeColor: CGColor, lineWidth: CGFloat) {
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
    }
}
#endif
