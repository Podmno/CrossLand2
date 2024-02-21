//
//  VCCellLoading.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/21.
//  Copyright © 2024 TRIStudio. All rights reserved.
//

import UIKit

class VCCellLoading: UIViewController {
    
    @IBOutlet weak var piLoading: UIActivityIndicatorView!
    @IBOutlet weak var imgTitle: UIImageView!
    @IBOutlet weak var btnRetry: UIButton!
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbInformation: UILabel!
    
    @IBOutlet weak var lbFootnote: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        piLoading.startAnimating()
        imgTitle.isHidden = true
        btnRetry.isHidden = true
        lbTitle.isHidden = true
        lbInformation.isHidden = true
        lbFootnote.isHidden = true
    }

    func switchToForumBan() {
        
        lbTitle.text = "不允许访问此版面"
        
        
    }
    
    func switchToFailed() {
        piLoading.stopAnimating()
        piLoading.isHidden = true
        imgTitle.isHidden = false
        btnRetry.isHidden = false
        lbTitle.isHidden = false
        lbInformation.isHidden = false
        lbFootnote.isHidden = false
        
    }
    
    
    @IBAction func btnClickedRefresh(_ sender: Any) {
        
    }
    

}
