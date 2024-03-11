//
//  VCForumMain.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/16.
//  Copyright © 2024 TRIStudio. All rights reserved.
//

import UIKit
import Hero
import SnapKit
import SwiftUI
import SkeletonView

class VCForumMain: UIViewController {

    @IBOutlet weak var mainHolderView: UIView!
    
    @IBOutlet weak var bottomBarHolderView: UIVisualEffectView!
    let bottomBar = VCBottomBar(nibName: "VCBottomBar", bundle: Bundle.main)
    //let dsTableMain = VCForumMainTable()
    let mainForumView = VCForumView(nibName: "VCForumView", bundle: Bundle.main)
    
    let pageSpotlight = VCSpotlight(nibName: "VCSpotlight", bundle: Bundle.main)
    
    let navForum = VCForumNav(nibName: "VCForumNav", bundle: Bundle.main)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hero.isEnabled = true
        
        
        self.bottomBarHolderView.contentView.addSubview(bottomBar.view)
        bottomBar.view.backgroundColor = UIColor.clear
        bottomBar.view.snp.makeConstraints { make in
            make.centerYWithinMargins.equalToSuperview()
            make.height.equalTo(35)
            make.left.right.equalToSuperview()
        }
        
        self.mainHolderView.addSubview(mainForumView.view)
        mainForumView.view.snp.makeConstraints { make in
            //make.left.equalToSuperview().offset(0)
            make.top.left.bottom.right.equalToSuperview()
        }

        pageSpotlight.modalPresentationStyle = .overFullScreen
        pageSpotlight.modalTransitionStyle = .crossDissolve
        pageSpotlight.view.backgroundColor = .clear
        pageSpotlight.modalPresentationCapturesStatusBarAppearance = true
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.splitViewController?.maximumPrimaryColumnWidth = 600
        self.splitViewController?.minimumPrimaryColumnWidth = 600
        
        let ss = TRSS()
        ss.slotPresentSpotlightPage(self, #selector(pushSpotlightView))

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // TODO: 外部 API
        mainForumView.tableMain.reloadData()
        
        self.splitViewController?.showDetailViewController(navForum, sender: self)
    }
    
    
    @objc func pushSpotlightView() {
        print("To SpotlightView")
        
        self.present(pageSpotlight, animated: true)
        //self.navigationController?.pushViewController(pageSpotlight, animated: true)
    }
}
