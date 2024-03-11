//
//  VCForumView.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/13.
//

import UIKit

// TODO: VCForumMain > VCForumView 迁移

class VCForumView: UIViewController {

    @IBOutlet weak var tableMain: UITableView!
    
    let tableMainProvider = VCForumViewTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableMain.delegate = tableMainProvider
        tableMain.dataSource = tableMainProvider
        
        tableMain.separatorStyle = .none
        tableMain.allowsSelection = false
        tableMain.delaysContentTouches = false
        //tvMain.allowsSelection = false
        //tvMain.delaysContentTouches = false
    }




}


class VCForumViewTable: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let vcTitle = VCCellForumTitle(nibName: "VCCellForumTitle", bundle: Bundle.main)
    let vcLoading = VCCellLoading(nibName: "VCCellLoading", bundle: Bundle.main)
    let vcSkeleton = VCCellSkeleton(nibName: "VCCellSkeleton", bundle: Bundle.main)
    
    var tableViewSelf: UITableView? = nil
    
    override init() {
        super.init()
        bindTRSS()
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
    
    // MARK: - Bind TRSS Functions & ObjC Bind
    
    func bindTRSS() {
        let ss = TRSS()
        ss.slotToggleMainForumRefresh(self, #selector(toggleRefreshForum))
    }
    
    @objc func toggleRefreshForum() {
        print("TRSS / toggleTotalRefresh")
        
        vcTitle.callBackCellHeightWillChange = {
            self.tableViewSelf?.beginUpdates()
        }
        
        vcTitle.callBackCellHeightDidChange = {
            self.tableViewSelf?.endUpdates()
        }
        self.vcLoading.switchToLoading()
        uiSwitchToLoading()
        checkNetwork()
    }
    
    
    // MARK: - Internet Connection
    
    let API = LCAPI()
    
    func checkNetwork() {
        let network_check_queue = DispatchQueue(label: "studio.tri.landx2.networkCheck")
        
        network_check_queue.async {
            
            let repo = self.API.checkNetworkStatus()
            
            if (repo == .success) {
                
                print("network OK.")
                let cdn_image = self.API.getCDNPath()
                LCStorage.shared.globalSaveCDNImageURL(cdnUrl: cdn_image)
                
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
    
    // 当前已经加载的最新 Page，用于进行请求
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
            tableView.register(VCForumViewTableCell.self, forCellReuseIdentifier: "cell")
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
                make.left.equalTo(cell.snp.left).offset(16)
                make.right.equalTo(cell.snp.right).offset(-16)
            }
            cell.contentView.isUserInteractionEnabled = false
            return cell
        }
        
        if (indexPath.row == threadContent.count + 1) {
            let cell = UITableViewCell()
            
            cell.contentView.addSubview(vcSkeleton.view)
            vcSkeleton.view.snp.makeConstraints { make in
                make.top.bottom.left.right.equalToSuperview()
            }
            vcSkeleton.view.showAnimatedGradientSkeleton()
            return cell
        }
        
        
        let thread_row = indexPath.row - 1
        
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? VCForumViewTableCell
        
        if (cell == nil) {
            cell = VCForumViewTableCell(style: .default, reuseIdentifier: "cell")
        } else {
            cell?.removeThreadView()
        }
        
        cell!.setupContent(thread: threadContent[thread_row])

        //cell.awakeFromNib()
        return cell!
        

    }
    
    
    
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
    
    // 锁：防止重复的网络请求
    var lockForumLoading = false
    func dealWithFooter() {
        if scrollViewSelf == nil || tableViewSelf == nil {
            print("<!> Nil scrool view, table view, skip deal with footer")
        }
        
        if tableViewSelf?.contentSize.height == 0 {
            return
        }
        
        
        // 60: 偏移量用于稍微看到加载动画就触发网络请求与加载
        let footer_offset = tableViewSelf!.contentSize.height - tableViewSelf!.frame.size.height - 60
        
        if (lockForumLoading) {
            return
        }
        
        if tableViewSelf!.contentOffset.y >= footer_offset {
            lockForumLoading = true
            loadForum()
        }
    }
    
}

// MARK: - TableView Cell

class VCForumViewTableCell: UITableViewCell {
    
    
    
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
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
            
            make.bottom.equalToSuperview().offset(0)
        }
        
    }
    
    func removeThreadView() {
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
    }
}

