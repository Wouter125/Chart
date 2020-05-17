//
//  CGFloat+Extension.swift
//  
//
//  Created by Wouter van de Kamp on 17/05/2020.
//

#if canImport(UIKit)
import UIKit

extension CGFloat {
    func modulate(from: [CGFloat], to: [CGFloat], limit: Bool) -> CGFloat {
        let result = to[0] + (((self - from[0]) / (from[1] - from[0])) * (to[1] - to[0]))
        return limit ? [[result, to.min()!].max()!, to.max()!].min()! : result
    }
}

#endif
