//
//  VCSettingsHolder.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/24.
//  Copyright © 2024 TRIStudio. All rights reserved.
//

import UIKit
import SwiftUI
import SnapKit

class VCSettingsHolder: UIViewController {

    @IBOutlet weak var centerView: UIView!
    
    @IBOutlet weak var btnClose: UIButton!
    
    

    let button_helper = TRButtonAnimation()
    let swiftUISettingsHost = UIHostingController(rootView: SUSettings())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(goAcknowledgementPage), name: Notification.Name("landXGoAcknowledgement") , object: nil)

        self.centerView.addSubview(swiftUISettingsHost.view)
        self.swiftUISettingsHost.view.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        self.button_helper.attachAnimationToButton(btnClose)
    }



    @IBAction func btnClickedClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func goAcknowledgementPage() {
        print("Go Acknowledge")
        //UIApplication.shared.open(url!)
        //self.present(ack!, animated: true)
    }
    
}
