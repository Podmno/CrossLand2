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
        
        btnMenu.addTarget(self, action: #selector(touchDown), for: .touchDown)
        btnMenu.addTarget(self, action: #selector(touchUp), for: .touchUpInside)
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
            
        }
        
        let menu1 = UIMenu(title: "", options: .displayInline, children: [menu_post, menu_notice, menu_log, menu_search])
        let menu2 = UIMenu(title: "", options: .displayInline ,children: [menu_settings])
        menuMainContent = UIMenu(title: "主菜单", children: [menu1, menu2])
        
        self.btnMenu.menu = menuMainContent
        self.btnMenu.showsMenuAsPrimaryAction = true
    }
    
    private var downStart = Date()
    private static var duration = 0.1 // changing to 0.5 makes it easier to test

    
    @objc func touchDown(_ button: UIButton) {
        downStart = Date() // Note when the touch-down happens
        
        UIView.animate(withDuration: Self.duration, delay: 0.0, options: .curveEaseIn) {
            button.transform = CGAffineTransform(scaleX: 0.93, y: 0.93)
            
        }
    }

    @objc func touchUp(_ button: UIButton) {
        // Delay the touch-up animation if needed
        let delay = max(downStart.timeIntervalSinceNow + Self.duration, 0.0)
        UIView.animate(withDuration: Self.duration, delay: delay, options: .curveEaseOut) {
            button.transform = .identity
        }
    }

}
