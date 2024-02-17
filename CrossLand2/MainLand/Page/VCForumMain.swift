//
//  VCForumMain.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/16.
//  Copyright © 2024 TRIStudio. All rights reserved.
//

import UIKit
import SnapKit

class VCForumMain: UIViewController {

 
    @IBOutlet weak var tvMain: UITableView!
    
    let dsTableMain = VCForumMainTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvMain.delegate = dsTableMain
        tvMain.dataSource = dsTableMain
        
        tvMain.separatorStyle = .none
        tvMain.allowsSelection = false
        tvMain.delaysContentTouches = false

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tvMain.reloadData()
    }

    
}

class VCForumMainTable: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let vcTitle = VCCellForumTitle(nibName: "VCCellForumTitle", bundle: Bundle.main)
    
    let vcForumDemo = VCCellForumMain(nibName: "VCCellForumMain", bundle: Bundle.main)
    
    var tableViewSelf: UITableView? = nil
    
    override init() {
        super.init()
        
        vcTitle.callBackCellHeightWillChange = {
            self.tableViewSelf?.beginUpdates()
        }
        
        vcTitle.callBackCellHeightDidChange = {
            self.tableViewSelf?.endUpdates()
        }
        
        
        self.vcTitle.setupTitleInformation("""
                                           &bull;  重新出发 <br />
                                           &bull;  关于X岛与A岛关系的说明：&gt;&gt;No.50000002<strong><a href="/t/50000002">置顶串</a></strong><br />
                                           &bull;  上手前建议您阅读：&gt;&gt;No.50000001<strong><a href="/t/50000001">【全岛总版规】</a></strong><br />
                                           &bull;  我们建议您开串时抛弃任何非必要性的身份标签，直接进入话题，否则您可能将面临不友善态度<br />
                                           &bull;  综合版为综合性版块，请优先选择各关联性强分版。<br />
                                           &bull; 工作考试及投资相关请至社畜(校园)版，好物推荐/购物拼团请转买买买版，手机及装机咨询请转数码版，无公众讨论意义及记录请转日记版
                                           <br />
                                           &bull;  全岛禁止违法违规话题以及晒交配，请尊重他人的同时尊重自己。<br />
                                           &bull;  特殊事务可于版务版块发串，私信官方微博@X岛揭示板，或邮件联系<a href=mailtohelp@nmbxd.com>help@nmbxd.com</a>
                                           &bull; 客户端下载地址：https://app.nmbxd.com
                                           """)
        self.vcTitle.setupLargeTitle("综合版1")

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewSelf = tableView
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            cell.addSubview(vcTitle.view)
            
            vcTitle.view.snp.makeConstraints { make in
                make.top.equalTo(cell.snp.top)
                make.bottom.equalTo(cell.snp.bottom)
                make.left.equalTo(cell.snp.left)
                make.right.equalTo(cell.snp.right)
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
        return UITableView.automaticDimension
    }
    
    
}
