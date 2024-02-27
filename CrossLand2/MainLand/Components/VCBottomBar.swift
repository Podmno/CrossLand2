//
//  VCBottomBar.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/13.
//

import UIKit
import SnapKit

class VCBottomBar: UIViewController {

    @IBOutlet weak var btnMenu: UIButton!
    var menuMainContent: UIMenu = UIMenu()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createMenu()
        
    }



    func createMenu() {
        
        let menu_post = UIAction(title: "发帖", image: UIImage(systemName: "paperplane")) { _ in
            
        }
        
        let menu_notice = UIAction(title: "消息", image: UIImage(systemName: "bell")) { _ in
            
        }
        
        let menu_log = UIAction(title: "订阅", image: UIImage(systemName: "bookmark")) { _ in
            
        }
        
        let menu_search = UIAction(title: "检索", image: UIImage(systemName: "magnifyingglass")) { _ in
            
        }
        
        let menu_settings = UIAction(title: "设置", image: UIImage(systemName: "gear")) { _ in
            
            let settings_demo = VCSettingsHolder(nibName: "VCSettingsHolder", bundle: Bundle.main)
            self.present(settings_demo, animated: true)
        }
        
        let menu1 = UIMenu(title: "", options: .displayInline, children: [menu_post, menu_notice, menu_log, menu_search])
        let menu2 = UIMenu(title: "", options: .displayInline ,children: [menu_settings])
        menuMainContent = UIMenu(title: "主菜单", children: [menu1, menu2])
        
        self.btnMenu.menu = menuMainContent
        self.btnMenu.showsMenuAsPrimaryAction = true
    }


}
