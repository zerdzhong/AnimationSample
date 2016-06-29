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
    
    override func viewDidLoad() {
        
        switch animtaionType {
        case .some(AnimationSampleType.sector):
            
            break
        default:
            break
        }
        
    }
}
