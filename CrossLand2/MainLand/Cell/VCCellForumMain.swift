//
//  VCCellForumMain.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/14.
//

import UIKit

class VCCellForumMain: UIViewController {

    
    @IBOutlet weak var btnPo: UIButton!
    @IBOutlet weak var btnSAGE: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if #available(macCatalyst 15.0,iOS 15.0, *) {
            btnPo.backgroundColor = UIColor.tintColor
            btnSAGE.backgroundColor = UIColor.tintColor
        } else {
            // Fallback on earlier versions
        }
    }


    /// 设定 View 为卡片形式
    public func styleEnableCard(_ enabled: Bool) {
        if (enabled) {
            self.view.layer.cornerRadius = 16.0
            self.view.backgroundColor = UIColor.systemGray6
        } else {
            self.view.layer.cornerRadius = 0.0
            self.view.backgroundColor = UIColor.systemBackground
        }
        
    }


}
