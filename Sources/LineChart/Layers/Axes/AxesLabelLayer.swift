//
//  AxesLabelLayer.swift
//  
//
//  Created by Wouter van de Kamp on 17/05/2020.
//

#if canImport(UIKit)
import UIKit

class AxesLabelLayer: CATextLayer {
    init(foregroundColor: CGColor) {
        super.init()
        configureLayer(foregroundColor: foregroundColor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureLayer(foregroundColor: CGColor) {
        self.foregroundColor = foregroundColor
        self.alignmentMode = .center
        self.fontSize = 12.0
        self.contentsScale = UIScreen.main.scale
    }
}
#endif
