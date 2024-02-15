//
//  VCCellForumMain.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/14.
//

import UIKit

class VCCellForumMain: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /// 设定 View 为卡片形式
    public func styleEnableCard(_ enabled: Bool) {
        if (enabled) {
            self.view.layer.cornerRadius = 16.0
            self.view.layer.masksToBounds = true
            self.view.backgroundColor = UIColor.systemGroupedBackground
        } else {
            self.view.layer.cornerRadius = 0.0
            self.view.layer.masksToBounds = true
            self.view.backgroundColor = UIColor.systemBackground
        }
        
    }


}
