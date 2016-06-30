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
            
            sectorLayer.strokeEnd = CGFloat(1 - progress)
            
            if progress == 1 {
                DispatchQueue.main.after(when: .now() + 0.1, execute: { 
                    self.reveal()
                })
            }
            if progress == 0 {
                DispatchQueue.main.after(when: .now() + 0.1, execute: {
                    self.progress = 0.05
                    self.startAnimaition()
                })
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
        
        strokeLayer.path = strokePath(radius:cicleRadius() + 10).cgPath
        sectorLayer.frame = self.bounds
        sectorLayer.path = sectorPath().cgPath
        sectorLayer.lineWidth = cicleRadius()
    }
    
    private func setupView() {
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        strokeLayer.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        strokeLayer.strokeColor = UIColor.clear().cgColor
        strokeLayer.fillRule = kCAFillRuleEvenOdd
        strokeLayer.lineWidth = 5
        
        sectorLayer.fillColor = UIColor.clear().cgColor
        sectorLayer.strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        sectorLayer.strokeEnd = 0
        sectorLayer.masksToBounds = true
        
        self.layer.addSublayer(strokeLayer)
        strokeLayer.addSublayer(sectorLayer)
        
        progress = 0
    }
    
    private func sectorPath() -> UIBezierPath {
        let radius: CGFloat = cicleRadius() / 2
        let arcCenter: CGPoint = CGPoint(x: sectorLayer.bounds.midX, y:sectorLayer.bounds.midY)
        
        let sectorStartAngle = CGFloat(-M_PI_2)
        let sectorEndAngle =  CGFloat(2 * M_PI) + sectorStartAngle
        let sectorPath = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: sectorStartAngle, endAngle: sectorEndAngle, clockwise: true)
    
        return sectorPath.reversing()
    }
    
    private func strokePath(radius: CGFloat) -> UIBezierPath {
        let strokePath = UIBezierPath(roundedRect: bounds, cornerRadius: 0)
        strokePath.append(UIBezierPath(ovalIn: circleFrame(radius: radius)))
        strokePath.usesEvenOddFillRule = true
        return strokePath
    }
    
    private func circleFrame(radius: CGFloat) -> CGRect {
        var circleFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: 2 * radius, height: 2 * radius))
        circleFrame.origin.y = (self.frame.height - circleFrame.height) / 2
        circleFrame.origin.x = (self.frame.width - circleFrame.width) / 2
        return circleFrame
    }
    
    private func cicleRadius() -> CGFloat {
        if progress == 0 {
            return 0
        }
        return (min(self.frame.width, self.frame.height) - 30) / 2
    }
    
    func startAnimaition() {
        UIView.animate(withDuration: 1) { 
            self.layoutSubviews()
        }
    }
    
    private func reveal() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let finalRadius = 2 * sqrt((center.x*center.x) + (center.y*center.y))
        
        let lineWidthAniamtion = CABasicAnimation(keyPath: "path")
        lineWidthAniamtion.fromValue = strokeLayer.path
        lineWidthAniamtion.toValue = strokePath(radius: finalRadius).cgPath
        lineWidthAniamtion.duration = 1
        lineWidthAniamtion.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        strokeLayer.path = strokePath(radius: finalRadius).cgPath
        CATransaction.commit()
        
        strokeLayer.add(lineWidthAniamtion, forKey: "strokeWidth")
    }
}
