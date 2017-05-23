//
//  Dot.swift
//  PageProgressBar
//
//  Created by Rob Norback on 5/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

class Dot: CAShapeLayer {
    
    init(radius:CGFloat, position:CGPoint, color:UIColor) {
        super.init()
        
        let circlePath = UIBezierPath(
            arcCenter: position,
            radius: radius,
            startAngle: CGFloat(0),
            endAngle:CGFloat(Double.pi * 2),
            clockwise: true
        )
        
        path = circlePath.cgPath
        fillColor = color.cgColor
        strokeColor = UIColor.clear.cgColor
        lineWidth = 1.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
