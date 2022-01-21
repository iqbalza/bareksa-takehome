//
//  CustomMarker.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 20/01/22.
//

import Foundation
import Charts

class CircleMarker: MarkerImage {
    
    @objc var color: UIColor
    @objc var radius: CGFloat = 4
    
    @objc public init(color: UIColor) {
        self.color = color
        super.init()
    }
    
    override func draw(context: CGContext, point: CGPoint) {
        let circleRect = CGRect(x: point.x - radius, y: point.y - radius, width: radius * 2, height: radius * 2)
        context.setFillColor(color.cgColor)
        context.fillEllipse(in: circleRect)
        
        context.restoreGState()
    }
    
    
}
