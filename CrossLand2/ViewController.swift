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
    
    var coreSplitController: UISplitViewController? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let mainForum = VCForumMain(nibName: "VCForumMain", bundle: Bundle.main)
        
        
        coreSplitController = UISplitViewController(style: .doubleColumn)
        coreSplitController?.modalPresentationStyle = .overFullScreen
        coreSplitController?.modalTransitionStyle = .crossDissolve
        coreSplitController?.preferredSplitBehavior = .tile
        coreSplitController?.preferredDisplayMode = .twoOverSecondary
        
        
        coreSplitController?.setViewController(mainForum, for: .primary)
        
        
        //coreNavigationController = UINavigationController(rootViewController: mainForum)
        //coreNavigationController?.navigationBar.isHidden = true
        
        //coreNavigationController?.modalPresentationStyle = .overFullScreen
        //coreNavigationController?.modalTransitionStyle = .crossDissolve
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.present(settingsViewController, animated: true)
        self.present(coreSplitController!, animated: true)
    }


}

