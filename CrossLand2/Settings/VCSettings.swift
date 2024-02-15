//
//  VCSettings.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/14.
//

import UIKit
import SnapKit



class VCSettings: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let viewHeader = UIView()
    
    @IBOutlet weak var visualHeader: UIVisualEffectView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let view_cell = UITableViewCell()
        
        if (indexPath.row >= settingsViewStack.count) {
            return view_cell
        }
        view_cell.addSubview(settingsViewStack[indexPath.row])
        settingsViewStack[indexPath.row].snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        //settingsViewStack[indexPath.row].frame = view_cell.bounds
        return view_cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        //if (indexPath.row >= settingsViewStack.count) {
        //    return 0.0
        //}
        //return settingsViewStackHeight[indexPath.row]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset_Y = scrollView.contentOffset.y
        
        // 标题动画偏移： 50 ~ 100
        // 字体： 22 -> 10
        let trans_progress = (offset_Y - 50) / 50
        if (offset_Y <= 50) {
            navigationTitle?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
            visualHeader.alpha = 0.0
        }
        
        if (offset_Y < 100 && offset_Y > 50) {
            
            
            let font_decide = 30 - (offset_Y - 50) * 0.25
            navigationTitle?.font = UIFont.systemFont(ofSize: font_decide, weight: .bold)
            visualHeader.alpha = 1.0 * trans_progress
            
        }
        
        if (offset_Y >= 100) {
            visualHeader.alpha = 1.0
        }
        
        self.view.bringSubviewToFront(navigationView!)
    }
    
    
    @IBOutlet weak var mainTableView: UITableView!
    var navigationView: UIView?
    var navigationTitle: UILabel?
    
    func createNavigationView() {
        navigationView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        navigationView?.clipsToBounds = true
        
        navigationTitle = UILabel()
        navigationTitle?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        navigationTitle?.text = "偏好设置"
        
        navigationView?.addSubview(navigationTitle!)
        navigationTitle!.snp.makeConstraints { make in
            make.bottom.equalTo(navigationView!.snp.bottom)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createNavigationView()
        createSettings()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.reloadData()
        
        mainTableView.tableHeaderView = navigationView
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.separatorStyle = .none;
        
        visualHeader.alpha = 0.0
    }

    // MARK: - Settings View Creator
    
    var settingsViewStack: [UIView] = []
    var settingsViewStackHeight: [CGFloat] = []
    
    func createSettings() {
        
        // 通用
        let icon_general_view = UIImageView(image: UIImage(systemName: "gear"))
        icon_general_view.tintColor = .label
        let general_label = UILabel()
        general_label.text = "通常"
        
        let general_view = UIView()
        general_view.addSubview(icon_general_view)
        general_view.addSubview(general_label)
        
        
        icon_general_view.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        general_label.snp.makeConstraints { make in
            //make.left.equalTo(icon_general_view.snp.right).offset(30)
            make.left.equalTo(50)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            
        }
        

        
        settingsViewStack.append(general_view)
        settingsViewStackHeight.append(50)
    }


}
