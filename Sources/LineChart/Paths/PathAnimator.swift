//
//  PathAnimator.swift
//  
//
//  Created by Wouter van de Kamp on 17/05/2020.
//

#if canImport(UIKit)
import UIKit

class PathAnimator {
    private var animationDuration: CFTimeInterval
    private var timingFunction: CAMediaTimingFunction
    
    init(animationDuration: CFTimeInterval, timingFunction: CAMediaTimingFunction) {
        self.animationDuration = animationDuration
        self.timingFunction = timingFunction
    }
    
    public func addPathAnimation(to layer: CAShapeLayer, path: CGPath?) {
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = animationDuration
        animation.fromValue = layer.path != nil ? layer.path : path
        animation.toValue = path
        animation.timingFunction = timingFunction
        layer.add(animation, forKey: nil)
        layer.path = path
    }
}
#endif
