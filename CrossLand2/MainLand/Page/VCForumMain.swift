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
import SkeletonView

class VCForumMain: UIViewController {

 
    @IBOutlet weak var tvMain: UITableView!

    
    @IBOutlet weak var bottomBarHolderView: UIVisualEffectView!
    let bottomBar = VCBottomBar(nibName: "VCBottomBar", bundle: Bundle.main)
    let dsTableMain = VCForumMainTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        self.bottomBarHolderView.contentView.addSubview(bottomBar.view)
        bottomBar.view.backgroundColor = UIColor.clear
        bottomBar.view.snp.makeConstraints { make in
            make.centerYWithinMargins.equalToSuperview()
            make.height.equalTo(50)
            make.left.right.equalToSuperview()
        }
        
        
        tvMain.delegate = dsTableMain
        tvMain.dataSource = dsTableMain
        
        tvMain.separatorStyle = .none
        tvMain.allowsSelection = false
        tvMain.delaysContentTouches = false
        

        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.splitViewController?.maximumPrimaryColumnWidth = 600
        self.splitViewController?.minimumPrimaryColumnWidth = 600

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        tvMain.reloadData()
        
    }
}

class VCForumMainTable: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let vcTitle = VCCellForumTitle(nibName: "VCCellForumTitle", bundle: Bundle.main)
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

        uiSwitchToLoading()
        checkNetwork()
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
                    
                    // 加载 Forum
                    self.loadForum()
                }
                
            } else {

                DispatchQueue.main.async {
                    self.vcLoading.switchToFailed()
                }
            }
        }
    }
    
    var currentLastPage: UInt = 0
    
    
    func loadForum() {
        currentLastPage += 1
        let network_check_queue = DispatchQueue(label: "studio.tri.landx2.loadForum")
        
        network_check_queue.async {
            
            let repo = self.API.getForum(forumID: 4, forumPage: self.currentLastPage)
            self.threadContent.append(contentsOf: repo)
            DispatchQueue.main.async {
                self.tableViewSelf?.reloadData()
                self.lockForumLoading = false
            }
            
        }
        
        
    }
    
    /// 装载的要展示的 threadContent
    var threadContent: [LSThread] = []
    
    // MARK: - TableView Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewSelf = tableView
        
        if (statusLoading) {
            return 1
        }
        
        return threadContent.count + 2
    }
    
    var registered = false
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 注册 TableViewCell

        if (!registered) {
            tableViewSelf = tableView
            tableView.register(VCForumMainTableCell.self, forCellReuseIdentifier: "cell")
            registered = true
        }
        
        
        
        
        if (statusLoading) {
            let cell = UITableViewCell()
            cell.addSubview(vcLoading.view)
            vcLoading.view.snp.makeConstraints {  make in
                make.top.bottom.left.right.equalToSuperview()
            }
            cell.contentView.isUserInteractionEnabled = false
            return cell
        }
        
        if (indexPath.row == 0) {
            let cell = UITableViewCell()
            cell.addSubview(vcTitle.view)
            
            vcTitle.view.snp.makeConstraints { make in
                make.top.equalTo(cell.snp.top)
                make.bottom.equalTo(cell.snp.bottom)
                make.left.equalTo(cell.snp.left).offset(14)
                make.right.equalTo(cell.snp.right).offset(-14)
            }
            cell.contentView.isUserInteractionEnabled = false
            return cell
        }
        
        if (indexPath.row == threadContent.count + 1) {
            let cell = UITableViewCell()
            skeletonViewFooter.view.showAnimatedGradientSkeleton()
            cell.addSubview(skeletonViewFooter.view)
            skeletonViewFooter.view.snp.makeConstraints { make in
                make.top.bottom.left.right.equalToSuperview()
            }
            return cell
        }
        
        
        let thread_row = indexPath.row - 1
        
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? VCForumMainTableCell
        
        if (cell == nil) {
            cell = VCForumMainTableCell(style: .default, reuseIdentifier: "cell")
        } else {
            cell?.removeThreadView()
        }
        
        
        
        cell!.setupContent(thread: threadContent[thread_row])

        //cell.awakeFromNib()
        return cell!
        

    }
    
    let skeletonViewFooter = VCCellForumMain()
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if (statusLoading) {
            return 600
        }
        
        return UITableView.automaticDimension
    }
    
    
    var scrollViewSelf: UIScrollView? = nil
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Scrool 处理
        scrollViewSelf = scrollView
        dealWithFooter()
    }
    
    
    var lockForumLoading = false
    func dealWithFooter() {
        if scrollViewSelf == nil || tableViewSelf == nil {
            print("<!> Nil scrool view, table view, skip deal with footer")
        }
        
        if tableViewSelf?.contentSize.height == 0 {
            return
        }
        
        
        // 40: 偏移量用于稍微看到加载动画就触发网络请求与加载
        let footer_offset = tableViewSelf!.contentSize.height - tableViewSelf!.frame.size.height - 60
        
        if (lockForumLoading) {
            return
        }
        
        if tableViewSelf!.contentOffset.y >= footer_offset {
            // FIXME: 需要在加载时进行堵塞
            // FIXME: 已经启用了 TableViewCell 复用但复用绘制有问题
            print(footer_offset)
            lockForumLoading = true
            loadForum()
        }
        
        
    }
    
    


    
}

class VCForumMainTableCell: UITableViewCell {
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupContent(thread: LSThread) {
        let forumViewController = VCCellForumMain(thread: LSThread())
        forumViewController.setupThread(thread)
        self.contentView.addSubview(forumViewController.view)
        forumViewController.view.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
    }
    
    func removeThreadView() {
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
    }
}
