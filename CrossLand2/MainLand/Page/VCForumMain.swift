//
//  VCForumMain.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/16.
//  Copyright © 2024 TRIStudio. All rights reserved.
//

import UIKit
import SnapKit
import SwiftUI

class VCForumMain: UIViewController {


 
    @IBOutlet weak var tvMain: UITableView!
    
    let settings_demo = VCSettingsHolder(nibName: "VCSettingsHolder", bundle: Bundle.main)
    
    let dsTableMain = VCForumMainTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvMain.delegate = dsTableMain
        tvMain.dataSource = dsTableMain
        
        tvMain.separatorStyle = .none
        tvMain.allowsSelection = false
        tvMain.delaysContentTouches = false

        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.present(settings_demo, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tvMain.reloadData()
        
    }
}

class VCForumMainTable: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let vcTitle = VCCellForumTitle(nibName: "VCCellForumTitle", bundle: Bundle.main)
    
    let vcForumDemo = VCCellForumMain(nibName: "VCCellForumMain", bundle: Bundle.main)
    
    let vcLoading = VCCellLoading(nibName: "VCCellLoading", bundle: Bundle.main)
    
    var tableViewSelf: UITableView? = nil
    
    override init() {
        super.init()
        
        vcTitle.callBackCellHeightWillChange = {
            self.tableViewSelf?.beginUpdates()
        }
        
        vcTitle.callBackCellHeightDidChange = {
            self.tableViewSelf?.endUpdates()
        }

        //uiSwitchToLoading()
        //checkNetwork()
    }
    
    /// 状态：当前正在加载
    var statusLoading: Bool = false
    
    /// UI 切换为加载
    func uiSwitchToLoading() {
        statusLoading = true
    }
    
    
    // MARK: - Internet Connection
    
    let API = LCAPI()
    
    func checkNetwork() {
        let network_check_queue = DispatchQueue(label: "studio.tri.landx2.networkCheck")
        
        network_check_queue.async {
            
            let repo = self.API.checkNetworkStatus()
            
            if (repo == .success) {
                
                print("network OK.")
                
                DispatchQueue.main.async {
                    self.statusLoading = false
                    
                    self.tableViewSelf?.reloadData()
                }
                
                
            } else {
                
               
                DispatchQueue.main.async {
                    self.vcLoading.switchToFailed()
                }
                
                
            }
            
        }
        
    }
    
    // MARK: - TableView Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewSelf = tableView
        
        if (statusLoading) {
            return 1
        }
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        
        if (statusLoading) {
            cell.addSubview(vcLoading.view)
            vcLoading.view.snp.makeConstraints {  make in
                make.top.bottom.left.right.equalToSuperview()
            }
            return cell
        }
        
        switch indexPath.row {
        case 0:
            cell.addSubview(vcTitle.view)
            
            vcTitle.view.snp.makeConstraints { make in
                make.top.equalTo(cell.snp.top)
                make.bottom.equalTo(cell.snp.bottom)
                make.left.equalTo(cell.snp.left).offset(14)
                make.right.equalTo(cell.snp.right).offset(-14)
            }
            
        case 1:
            cell.addSubview(vcForumDemo.view)
            
            vcForumDemo.view.snp.makeConstraints { make in
                make.top.equalTo(cell.snp.top)
                make.bottom.equalTo(cell.snp.bottom)
                make.left.equalTo(cell.snp.left)
                make.right.equalTo(cell.snp.right)
            }
            
        default:
            break
        }
        
        

        cell.contentView.isUserInteractionEnabled = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if (statusLoading) {
            return 600
        }
        
        return UITableView.automaticDimension
    }
    
    
    
    
}
