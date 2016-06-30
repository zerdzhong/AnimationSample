//
//  DetailViewController.swift
//  AnimationSample
//
//  Created by zhongzhendong on 6/29/16.
//  Copyright © 2016 zerdzhong. All rights reserved.
//

import UIKit

enum AnimationSampleType {
    case sector
}

class DetailViewController: UIViewController {
    
    var animtaionType: AnimationSampleType?
    var containerView: UIView?
    
    override func viewDidLoad() {
        
        switch animtaionType {
        case .some(AnimationSampleType.sector):
            startSectorAnimation()
            break
        default:
            break
        }
        
    }
    
    private func startSectorAnimation() {
        containerView = SectorAnimationView()
        containerView!.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        containerView!.center = view.center
        
        view.addSubview(containerView!)
        
        let hintLabel = UILabel()
        hintLabel.text = "click anywhere to change progress"
        hintLabel.sizeToFit()
        hintLabel.center = view.center
        hintLabel.frame.origin.y -= containerView!.frame.height
        view.addSubview(hintLabel)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let sectorView = containerView as? SectorAnimationView {
            sectorView.progress += 0.1
            if sectorView.progress > 1 {
                sectorView.progress = 0
            }
        }
    }
}
