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
    public private(set) var currentDotNumber:Int
    ///Amount of time the animation takes
    public private(set) var duration:TimeInterval = 0.5
    
    ///Size of the progress orbs
    public private(set) var dotRadius:CGFloat = 0
    ///Distance between the orbs
    public private(set) var interDotDistance:CGFloat = 0
    
    //Scale of the progress line in relation to the width of the frame
    public var dotToLineScale:CGFloat = 0.7 {
        didSet {
            setNeedsLayout()
        }
    }
    ///The scale of the track dots in relation to the progress dots
    public var trackToProgressScale:CGFloat = 0.7 {
        didSet {
            setNeedsLayout()
        }
    }
    
    ///The track view that sits behind the progress view
    fileprivate var trackView:UIView = UIView()
    ///Color of empty progress track
    public var trackTintColor:UIColor = .lightGray {
        didSet {
            trackView.backgroundColor = trackTintColor
        }
    }
    
    ///View that actually shows percentage of progress
    fileprivate var progressView:UIView = UIView()
    ///Color of the progress bar
    public var progressTintColor:UIColor = .blue {
        didSet {
            progressView.backgroundColor = progressTintColor
        }
    }
    
    public init(numberOfDots:Int, orientation:Orientation, startingDot:Int = 1) {
        assert(numberOfDots > 0, "numberOfDots must be a positive number")
        assert(startingDot >= 0 && startingDot <= numberOfDots, "startingDot must be between 0 and numbersOfDots")
        
        self.orientation = orientation
        self.numberOfDots = numberOfDots
        self.currentDotNumber = startingDot
        
        super.init(frame: CGRect.zero)
        //must be in this order
        initTrackView()
        initProgressView(orientation)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        //make changes based on the frame changing
        calculateDotAndLineValuesBasedOnFrame(orientation)
        trackView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        trackView.layer.mask = getMaskLayer(orientation, dotScale: trackToProgressScale)
        progressView.layer.mask = getMaskLayer(orientation)
        updateProgress(toDot: currentDotNumber, animated: false)
    }
    
    fileprivate func initTrackView() {
        trackView.backgroundColor = trackTintColor
        self.addSubview(trackView)
    }
    
    fileprivate func initProgressView(_ orientation:Orientation) {
        switch orientation {
        case .horizontal:
            progressView.frame = CGRect(x: 0, y: 0, width: 0, height: self.frame.height)
        case .vertical:
            progressView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 0)
        }
        progressView.backgroundColor = progressTintColor
        self.addSubview(progressView)
    }
    
    public func updateProgress(toDot dot:Int, animated:Bool = true) {
        var progressDistance:CGFloat
        
        //Makes sure you can't go outside the progress bounds
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
    
    public func next(animated:Bool = true) {
        updateProgress(toDot: currentDotNumber + 1, animated: animated)
    }
    
    public func prev(animated:Bool = true) {
        updateProgress(toDot: currentDotNumber - 1, animated: animated)
    }
    
    public func reset(animated:Bool = true) {
        updateProgress(toDot: 0, animated: animated)
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
    
    fileprivate func getMaskLayer(_ orientation:Orientation, dotScale:CGFloat = 1.0) -> CALayer {
        
        let maskLayer = CALayer()
        for dotNum in 0...numberOfDots - 1 {
            
            let dot = Dot(
                radius: dotRadius * dotScale,
                position: dotPosition(orientation, dotNum: dotNum),
                color: .white
            )
            maskLayer.addSublayer(dot)
            
            if dotNum > 0 {
                let line = Line(
                    start: dotPosition(orientation, dotNum: dotNum - 1),
                    end: dotPosition(orientation, dotNum: dotNum),
                    color: .white,
                    width: dotRadius * dotToLineScale * dotScale
                )
                maskLayer.addSublayer(line)
            }
        }
        return maskLayer
    }
    
    fileprivate func dotPosition(_ orientation:Orientation, dotNum:Int)  -> CGPoint {
        switch orientation {
        case .horizontal:
            return CGPoint(
                x: dotRadius + interDotDistance * CGFloat(dotNum),
                y: dotRadius
            )
        case .vertical:
            return CGPoint(
                x: dotRadius,
                y: dotRadius + interDotDistance * CGFloat(dotNum)
            )
        }
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
}
