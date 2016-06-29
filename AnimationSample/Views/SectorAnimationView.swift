//
//  SectorAnimationView.swift
//  AnimationSample
//
//  Created by zhongzhendong on 6/29/16.
//  Copyright © 2016 zerdzhong. All rights reserved.
//

import UIKit

class SectorAnimationView: UIView {
    
    private var strokeLayer = CAShapeLayer()
    private var sectorLayer = CAShapeLayer()
    
    var progress:Double = 0 {
        didSet {
            if progress < 0 {
                progress = 0
            }else if progress >= 1 {
                progress = 1
            }
            
            sectorLayer.strokeEnd = CGFloat(progress)
            
            if progress == 1 {
                reveal()
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        strokeLayer.path = strokePath().cgPath
        sectorLayer.frame = self.bounds
        sectorLayer.path = sectorPath().cgPath
        sectorLayer.lineWidth = cicleRadius()
    }
    
    private func setupView() {
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        strokeLayer.fillColor = UIColor.clear().cgColor
        strokeLayer.strokeColor = UIColor.white().cgColor
        strokeLayer.lineWidth = 5
        
        sectorLayer.fillColor = UIColor.clear().cgColor
        sectorLayer.strokeColor = UIColor.white().cgColor
        sectorLayer.strokeEnd = 0
        sectorLayer.masksToBounds = true
        
        self.layer.addSublayer(strokeLayer)
        strokeLayer.addSublayer(sectorLayer)
        
        progress = 0
    }
    
    private func reveal() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let finalRadius = sqrt((center.x*center.x) + (center.y*center.y))
        
        let lineWidthAniamtion = CABasicAnimation(keyPath: "lineWidth")
        lineWidthAniamtion.fromValue = strokeLayer.lineWidth
        lineWidthAniamtion.toValue = 2*finalRadius
        lineWidthAniamtion.duration = 1
        lineWidthAniamtion.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        strokeLayer.lineWidth = 2*finalRadius
        CATransaction.commit()
        
        strokeLayer.add(lineWidthAniamtion, forKey: "strokeWidth")
    }
    
    private func sectorPath() -> UIBezierPath {
        let radius: CGFloat = cicleRadius() / 2
        let arcCenter: CGPoint = CGPoint(x: circleFrame().midX, y:circleFrame().midY)
        
        let sectorStartAngle = CGFloat(-M_PI_2)
        let sectorEndAngle =  CGFloat(2 * M_PI) + sectorStartAngle
        let sectorPath = UIBezierPath()
        sectorPath.addArc(withCenter: arcCenter, radius: radius, startAngle: sectorStartAngle, endAngle: sectorEndAngle, clockwise: true)
        
        return sectorPath
    }
    
    private func strokePath() -> UIBezierPath {
        let strokePath = UIBezierPath(ovalIn: circleFrame())
        return strokePath
    }
    
    private func circleFrame() -> CGRect {
        var circleFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: 2*cicleRadius(), height: 2*cicleRadius()))
        circleFrame.origin.y = (self.frame.height - circleFrame.height) / 2
        circleFrame.origin.x = (self.frame.width - circleFrame.width) / 2
        return circleFrame
    }
    
    private func cicleRadius() -> CGFloat {
        return (min(self.frame.width, self.frame.height) - 30) / 2
    }
}
