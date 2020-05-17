//
//  LineBackgroundLayer.swift
//  
//
//  Created by Wouter van de Kamp on 17/05/2020.
//

#if canImport(UIKit)
import UIKit

class LineBackgroundLayer: CAGradientLayer {
    override init() {
        super.init()
    }
    
    init(colors: [CGColor]) {
        super.init()
        configureLayer(colors: colors)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayer(colors: [CGColor]) {
        self.colors = colors
        self.startPoint = CGPoint(x: 0, y: 0)
        self.endPoint = CGPoint(x: 0, y: 1)
    }
}
#endif
