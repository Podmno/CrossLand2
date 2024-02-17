//
//  ViewController.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/7.
//

import UIKit

class ViewController: UIViewController {
    
    //let debugViewController = VCDebug(nibName: "VCDebug", bundle: Bundle.main)
    //let settingsViewController = VCSettings(nibName: "VCSettings", bundle: Bundle.main)
    var coreNavigationController: UINavigationController? = nil
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let mainForum = VCForumMain(nibName: "VCForumMain", bundle: Bundle.main)
        coreNavigationController = UINavigationController(rootViewController: mainForum)
        coreNavigationController?.navigationBar.isHidden = true
        
        coreNavigationController?.modalPresentationStyle = .overFullScreen
        coreNavigationController?.modalTransitionStyle = .crossDissolve
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.present(settingsViewController, animated: true)
        self.present(coreNavigationController!, animated: true)
    }


}

