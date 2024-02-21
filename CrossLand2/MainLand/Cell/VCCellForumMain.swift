//
//  VCCellForumMain.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/14.
//

import UIKit
import SnapKit

class VCCellForumMain: UIViewController {

    @IBOutlet weak var lbUserHash: UILabel!
    @IBOutlet weak var lbNo: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var btnPo: UIButton!
    @IBOutlet weak var btnSAGE: UIButton!
    @IBOutlet weak var tvMain: UITextView!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var csTopStackHeight: NSLayoutConstraint!
    @IBOutlet weak var csBottomStackHeight: NSLayoutConstraint!
    @IBOutlet weak var topStack: UIStackView!
    @IBOutlet weak var bottomStack: UIStackView!
    let cellManager = VCCellForumMainSubCellFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if #available(macCatalyst 15.0,iOS 15.0, *) {
            btnPo.backgroundColor = UIColor.tintColor
            btnSAGE.backgroundColor = UIColor.tintColor
        } else {
            // Fallback on earlier versions
        }
        
        let view_sage = cellManager.createSAGEInformation()
        let view_sage2 = cellManager.createUserInfo(username: "demo")
        let view_sage3 = cellManager.createUserEmail(username: "demo@demo.com")
        
        //callBackCellHeightWillChange()


        topStack.addArrangedSubview(view_sage)
        topStack.addArrangedSubview(view_sage2)
        topStack.addArrangedSubview(view_sage3)
        
        csTopStackHeight.constant = csTopStackHeight.constant + cellManager.getSAGEInformationViewHeight() * 3

        //topStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading:5 , bottom: 5, trailing: 5)
        
        //callBackCellHeightDidChange()
        
    }


    /// 设定 View 为卡片形式
    public func styleEnableCard(_ enabled: Bool) {
        if (enabled) {
            self.view.layer.cornerRadius = 16.0
            self.view.backgroundColor = UIColor.systemGray6
        } else {
            self.view.layer.cornerRadius = 0.0
            self.view.backgroundColor = UIColor.systemBackground
        }
        
    }
    
    
    /// Callback: 通知行高度发生了变化
    public var callBackCellHeightWillChange: () -> Void = { }

    /// Callback: 行高修改结束
    public var callBackCellHeightDidChange: () -> Void = { }


}

class VCCellForumMainSubCellFactory: NSObject {
    
    public func createSAGEInformation() -> UIView {
        let sage_info = UIView()
        
        let sage_label = UILabel()
        sage_label.text = "此串已被 SAGE"
        sage_label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        let sage_image = UIImageView(image: UIImage(systemName: "exclamationmark.triangle.fill"))
        sage_image.tintColor = UIColor.label
        sage_image.contentMode = .scaleAspectFit
        sage_info.addSubview(sage_label)
        sage_info.addSubview(sage_image)

        sage_image.snp.makeConstraints { make in
            make.centerYWithinMargins.equalToSuperview()
            make.height.equalTo(16)
            make.width.equalTo(16)
        }

        sage_label.snp.makeConstraints { make in
            make.centerYWithinMargins.equalToSuperview()
            make.left.equalTo(sage_image.snp.right).offset(8)
        }
        sage_info.layer.cornerRadius = 11.0
        sage_info.backgroundColor = UIColor.systemGray6

        return sage_info
    }
    
    public func createUserInfo(username: String) -> UIView {
        let sage_info = UIView()
        
        let sage_label = UILabel()
        sage_label.text = username
        sage_label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        let sage_image = UIImageView(image: UIImage(systemName: "h.circle"))
        sage_image.tintColor = UIColor.label
        sage_image.contentMode = .scaleAspectFit
        sage_info.addSubview(sage_label)
        sage_info.addSubview(sage_image)

        sage_image.snp.makeConstraints { make in
            make.centerYWithinMargins.equalToSuperview()
            make.height.equalTo(16)
            make.width.equalTo(16)
        }

        sage_label.snp.makeConstraints { make in
            make.centerYWithinMargins.equalToSuperview()
            make.left.equalTo(sage_image.snp.right).offset(8)
        }
        sage_info.layer.cornerRadius = 11.0
        sage_info.backgroundColor = UIColor.systemGray6

        return sage_info
    }
    
    public func createUserEmail(username: String) -> UIView {
        let sage_info = UIView()
        
        let sage_label = UILabel()
        sage_label.text = username
        sage_label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        let sage_image = UIImageView(image: UIImage(systemName: "at.circle"))
        sage_image.tintColor = UIColor.label
        sage_image.contentMode = .scaleAspectFit
        sage_info.addSubview(sage_label)
        sage_info.addSubview(sage_image)

        sage_image.snp.makeConstraints { make in
            make.centerYWithinMargins.equalToSuperview()
            make.height.equalTo(16)
            make.width.equalTo(16)
        }

        sage_label.snp.makeConstraints { make in
            make.centerYWithinMargins.equalToSuperview()
            make.left.equalTo(sage_image.snp.right).offset(8)
        }
        sage_info.layer.cornerRadius = 11.0
        sage_info.backgroundColor = UIColor.systemGray6

        return sage_info
    }
    
    public func getSAGEInformationViewHeight() -> CGFloat {
        return 14.0
    }
    
    
    public func createUserReplyLine(userPo: String, userContent: String) -> UIView {
        let user_reply_line = UIView()
        
        let user_label = UILabel()
        let content_label = UILabel()
        
        user_label.text = userPo
        content_label.text = userContent
        
        return user_reply_line
    }
    
    
}


extension UIStackView {

    func addArrangedSubview(_ v:UIView, withMargin m:UIEdgeInsets )
    {
        let containerForMargin = UIView()
        containerForMargin.addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            v.topAnchor.constraint(equalTo: containerForMargin.topAnchor, constant:m.top ),
            v.bottomAnchor.constraint(equalTo: containerForMargin.bottomAnchor, constant: m.bottom ),
            v.leftAnchor.constraint(equalTo: containerForMargin.leftAnchor, constant: m.left),
            v.rightAnchor.constraint(equalTo: containerForMargin.rightAnchor, constant: m.right)
        ])

        addArrangedSubview(containerForMargin)
    }
}
