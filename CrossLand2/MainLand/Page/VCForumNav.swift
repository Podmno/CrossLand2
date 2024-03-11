//
//  VCForumNav.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/25.
//  Copyright © 2024 TRIStudio. All rights reserved.
//

import UIKit

class VCForumNav: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Nav - Did load")
        
        self.view.backgroundColor = UIColor.systemBackground
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationBar.isHidden = true
        
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
