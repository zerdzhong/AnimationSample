//
//  ViewController.swift
//  AnimationSample
//
//  Created by zhongzhendong on 6/29/16.
//  Copyright © 2016 zerdzhong. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var animationList = ["扇形动画":AnimationSampleType.sector]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if let detailController = segue.destinationViewController as? DetailViewController {
            if let cell = sender as? UITableViewCell {
                detailController.animtaionType = animationList[(cell.textLabel?.text)!]
            }
        }
    }
}

extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animationList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "animationListCell")!
        
        let animationNames = [String](animationList.keys)
        
        cell.textLabel?.text = animationNames[indexPath.row]
        
        return cell
    }
}

