//
//  PathTransformer.swift
//  
//
//  Created by Wouter van de Kamp on 17/05/2020.
//

#if canImport(UIKit)
import UIKit

struct Boundaries {
    var minX: CGFloat
    var maxX: CGFloat
    
    var minY: CGFloat
    var maxY: CGFloat
}

class PathTransformer {
    private let data: [CGPoint]
    private let inset: UIEdgeInsets
    private let bounds: CGRect
    
    init(bounds: CGRect, data: [CGPoint], inset: UIEdgeInsets) {
        self.bounds = bounds
        self.data = data
        self.inset = inset
    }
    
    public func getTransform() -> CGAffineTransform {
        let boundaries = getBoundaries()
        
        let transform = CGAffineTransform(
            a: (bounds.width - inset.left - inset.right) / (boundaries.maxX - boundaries.minX),
            b: 0,
            c: 0,
            d: -1 * (bounds.height - inset.top - inset.bottom) / boundaries.maxY,
            tx: inset.left,
            ty: bounds.height - inset.bottom
        )
        
        return transform
    }
    
    private func getBoundaries() -> Boundaries {
        // TODO: <Wouter> Replace these with binary search
        let minX = data.max{ $0.x > $1.x }!.x
        let maxX = data.min{ $1.x < $0.x }!.x

        let minY = data.max{ $0.y > $1.y }!.y
        let maxY = data.min{ $1.y < $0.y }!.y
        
        return Boundaries(
            minX: minX,
            maxX: maxX,
            minY: minY,
            maxY: maxY
        )
    }
}
#endif
