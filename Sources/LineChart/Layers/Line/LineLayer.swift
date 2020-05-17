//
//  LineLayer.swift
//  
//
//  Created by Wouter van de Kamp on 17/05/2020.
//

#if canImport(UIKit)
import UIKit

class LineLayer: CAShapeLayer {
    override init() {
        super.init()
    }
    
    init(strokeColor: CGColor, lineWidth: CGFloat) {
        super.init()
        configureLayer(strokeColor: strokeColor, lineWidth: lineWidth)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayer(strokeColor: CGColor, lineWidth: CGFloat) {
        self.fillColor = UIColor.clear.cgColor
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
    }
}
#endif

