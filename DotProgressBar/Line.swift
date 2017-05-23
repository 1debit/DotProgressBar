//
//  Line.swift
//  PageProgressBar
//
//  Created by Rob Norback on 5/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

class Line: CAShapeLayer {
    
    init(start:CGPoint, end:CGPoint, color: UIColor, width:CGFloat) {
        super.init()
        
        //design the path
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        
        path = linePath.cgPath
        strokeColor = color.cgColor
        lineWidth = width
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

