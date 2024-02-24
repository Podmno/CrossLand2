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
    

    let swiftUISettingsHost = UIHostingController(rootView: SUSettings())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.centerView.addSubview(swiftUISettingsHost.view)
        self.swiftUISettingsHost.view.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }




}
