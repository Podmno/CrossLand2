//
//  VCDebug.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/8.
//

import UIKit
import SnapKit


class VCDebug: UIViewController {
    
    let bottomBar = VCBottomBar(nibName: "VCBottomBar", bundle: Bundle.main)
    let cell_demo = VCCellForumTitle(nibName: "VCCellForumTitle", bundle: Bundle.main)
    
    let cell_main = VCCellForumMain(nibName: "VCCellForumMain", bundle: Bundle.main)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupView()
    }
    
    func setupView() {
        self.view.addSubview(bottomBar.view)
        bottomBar.view.snp.makeConstraints { make in
            
            make.height.equalTo(80)
            make.bottom.equalTo(self.view).offset(0)
            make.left.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
        }
        self.view.addSubview(cell_demo.view)
        cell_demo.view.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.top.equalTo(self.view).offset(40)
            make.left.equalTo(self.view).offset(2)
            make.right.equalTo(self.view).offset(-2)
        }
        cell_demo.view.isUserInteractionEnabled = true
        
        self.view.addSubview(cell_main.view)
        cell_main.view.snp.makeConstraints { make in
            make.top.equalTo(self.cell_demo.view.snp_bottomMargin).offset(15)
            make.left.equalTo(self.view).offset(16)
            make.right.equalTo(self.view).offset(-16)
        }
        cell_main.styleEnableCard(true)
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
