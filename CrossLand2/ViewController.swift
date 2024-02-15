//
//  ViewController.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/7.
//

import UIKit

class ViewController: UIViewController {
    
    let debugViewController = VCDebug(nibName: "VCDebug", bundle: Bundle.main)
    let settingsViewController = VCSettings(nibName: "VCSettings", bundle: Bundle.main)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        debugViewController.modalPresentationStyle = .overFullScreen
        debugViewController.modalTransitionStyle = .crossDissolve
        self.present(debugViewController, animated: true)
        self.present(settingsViewController, animated: true)
    }


}

