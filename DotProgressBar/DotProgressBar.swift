//
//  DotProgressBar.swift
//  PageProgressBar
//
//  Created by Rob Norback on 5/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

public class DotProgressBar: UIView {

    public enum Orientation {
        case vertical, horizontal
    }
    
    ///Number of balls in progress meter
    public private(set) var numberOfDots:Int
    ///Bar orientation
    public private(set) var orientation:Orientation
    ///Current page number the progress bar is showing
    public private(set) var currentDotNumber:Int = 1
    ///Whether or not updating the progress should be animated (defaults to 'true')
    public private(set) var animated:Bool = true
    ///Amount of time the animation takes
    public private(set) var duration:TimeInterval = 1
    ///Completion block executed after progress bar is finished animating
    public var completion:() -> Void = {}
    ///Color of empty progress track
    public var trackTintColor:UIColor = .lightGray
    ///Color of the progress bar
    public var progressTintColor:UIColor = .blue
    ///Size of the progress orbs
    public private(set) var dotRadius:CGFloat = 0
    ///Distance between the orbs
    public private(set) var interDotDistance:CGFloat = 0
    ///Width of empty progress track
    public var trackWidth:CGFloat = 2
    ///View that actually shows percentage of progress
    fileprivate var progressView:UIView = UIView()
    
    public init(numberOfDots:Int, orientation:Orientation) {
        self.numberOfDots = numberOfDots
        self.orientation = orientation
        super.init(frame: CGRect.zero)
        initProgressView(orientation)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        //make changes based on the frame changing
        create()
    }
    
    fileprivate func initProgressView(_ orientation:Orientation) {
        switch orientation {
        case .horizontal:
            progressView.frame = CGRect(x: 0, y: 0, width: 0, height: self.frame.height)
        case .vertical:
            progressView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 0)
        }
        self.addSubview(progressView)
    }
    
    fileprivate func create() {
        self.backgroundColor = trackTintColor
        progressView.backgroundColor = progressTintColor
        calculateDotAndLineValuesBasedOnFrame(orientation)
        addMaskLayer(orientation)
        updateProgress(toDot: currentDotNumber, animated: false)
    }
    
    fileprivate func addMaskLayer(_ orientation:Orientation) {
        switch orientation {
        case .horizontal:
            addHorizontalMaskLayer()
        case .vertical:
            addVerticalMaskLayer()
        }
    }
    
    fileprivate func addHorizontalMaskLayer() {
        
        let maskLayer = CALayer()
        for page in 1...numberOfDots {
            
            let dot = Dot(
                radius: dotRadius,
                position: CGPoint(
                    x: dotRadius + interDotDistance * CGFloat(page - 1),
                    y: dotRadius
                ),
                color: trackTintColor
            )
            maskLayer.addSublayer(dot)
            
            if page > 1 {
                let line = Line(
                    start: CGPoint(
                        x: dotRadius + interDotDistance * CGFloat(page - 2),
                        y: dotRadius
                    ),
                    end: CGPoint(
                        x: dotRadius + interDotDistance * CGFloat(page - 1),
                        y: dotRadius
                    ),
                    color: trackTintColor,
                    width: trackWidth
                )
                maskLayer.addSublayer(line)
            }
        }
        self.layer.mask = maskLayer
    }
    
    fileprivate func addVerticalMaskLayer() {
        
        let maskLayer = CALayer()
        for page in 1...numberOfDots {
            
            let dot = Dot(
                radius: dotRadius,
                position: CGPoint(
                    x: dotRadius,
                    y: dotRadius + interDotDistance * CGFloat(page - 1)
                ),
                color: trackTintColor
            )
            maskLayer.addSublayer(dot)
            
            if page > 1 {
                let line = Line(
                    start: CGPoint(
                        x: dotRadius,
                        y: dotRadius + interDotDistance * CGFloat(page - 2)
                    ),
                    end: CGPoint(
                        x: dotRadius,
                        y: dotRadius + interDotDistance * CGFloat(page - 1)
                    ),
                    color: trackTintColor,
                    width: trackWidth
                )
                maskLayer.addSublayer(line)
            }
        }
        self.layer.mask = maskLayer
    }

    
    fileprivate func updateProgressFrame(_ orientation:Orientation, distance:CGFloat) {
        switch orientation {
        case .horizontal:
            progressView.frame = CGRect(
                x: 0,
                y: 0,
                width: distance,
                height: self.frame.height
            )
        case .vertical:
            progressView.frame = CGRect(
                x: 0,
                y: 0,
                width: self.frame.width,
                height: distance
            )
        }
        
    }
    
    public func updateProgress(toDot dot:Int, animated:Bool = true) {
        var progressDistance:CGFloat
        
        if dot < 1 {
            progressDistance = 0
            currentDotNumber = 0
        } else if dot > numberOfDots {
            progressDistance = dotRadius * 2 + interDotDistance * CGFloat(numberOfDots - 1)
            currentDotNumber = numberOfDots
        } else {
            progressDistance = dotRadius * 2 + interDotDistance * CGFloat(dot - 1)
            currentDotNumber = dot
        }
        
        if animated {
            UIView.animate(withDuration: duration) {
                self.updateProgressFrame(self.orientation, distance: progressDistance)
            }
        } else {
            updateProgressFrame(orientation, distance: progressDistance)
        }
    }

    fileprivate func calculateDotAndLineValuesBasedOnFrame(_ orientation:Orientation) {
        switch orientation {
        case .horizontal:
            dotRadius = frame.height/2
            interDotDistance = (frame.width - dotRadius * 2)/CGFloat(numberOfDots - 1)
        case .vertical:
            dotRadius = frame.width/2
            interDotDistance = (frame.height - dotRadius * 2)/CGFloat(numberOfDots - 1)
        }
    }
}
