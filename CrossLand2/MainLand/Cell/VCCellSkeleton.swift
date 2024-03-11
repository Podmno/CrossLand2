//
//  VCCellSkeleton.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/3/10.
//  Copyright © 2024 TRIStudio. All rights reserved.
//

import UIKit
import SkeletonView

class VCCellSkeleton: UIViewController {

    @IBOutlet weak var tv2: UITextView!
    @IBOutlet weak var lb1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tv2.showAnimatedGradientSkeleton()
        lb1.showAnimatedGradientSkeleton()
    }



}
