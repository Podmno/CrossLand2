//
//  VCCellForumMain.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/14.
//

import UIKit
import SnapKit

import SwiftyJSON

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
    
    @IBOutlet weak var picHeight: NSLayoutConstraint!
    
    @IBOutlet weak var picWidth: NSLayoutConstraint!
    
    let cellManager = VCCellForumMainSubCellFactory()
    
    /// 顶部 StackView 要展示的堆栈
    var topViewStack: [UIView] = []
    
    /// 底部 StackView 要展示的堆栈
    var bottomViewStack: [UIView] = []
    
    /// 保存用的 Thread 信息
    var storageThreadContent: LSThread? = nil
    
    public func setupThread(_ thread: LSThread) {
        storageThreadContent = thread
    }
    
    init(thread: LSThread) {
        super.init(nibName: "VCCellForumMain", bundle: Bundle.main)
        
        setupThread(thread)
    }
    
    init() {
        super.init(nibName: "VCCellForumMain", bundle: Bundle.main)
        
        let thread_demo = LSThread()
        thread_demo.threadUserHash = "HelloWorld\nHello"
        thread_demo.threadDate = "2000-01-01 10:00:00"
        thread_demo.threadID = 800000000
        
        let attr = TRAttributedFactory()
        
        thread_demo.threadContentAttributedString = attr.covertAttributedString("\n \nHelloasldkjklasjkldjljalskjdkljlaskjldjclkas\nd \njlc\nacskljlaksjdcljlakskdcjl\n aksjdcklqiowijo\naclskjlaksjcdiqo\n weui\naklscjlkajlwiiSD\ndasSDKANLSKDNWIQlknlzxn\naskldjk\nJKZn\nLJLKiuq_2")
        thread_demo.threadImg = "example"
        setupThread(thread_demo)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    
        if #available(macCatalyst 15.0,iOS 15.0, *) {
            btnPo.backgroundColor = UIColor.tintColor
            btnSAGE.backgroundColor = UIColor.tintColor
        } else {
            // Fallback on earlier versions
        }
        
        setupContentView()
        setupTopView()
        setupBottomView()
    }
    
    
    
    private func setupContentView() {
        lbUserHash.text = storageThreadContent?.threadUserHash ?? "Unknown"
        lbNo.text = "No.\(storageThreadContent?.threadID ?? 0)"
        lbTime.text = storageThreadContent?.threadDate ?? "2000-01-01(一)00:00:00"
        tvMain.attributedText = storageThreadContent?.threadContentAttributedString

        if (storageThreadContent?.threadImg.isEmpty ?? true) {
            picHeight.constant = 0
            picWidth.constant = 0
        } else {
            picHeight.constant = 150
            picWidth.constant = 150
        }
    }
    
    /// 设定 Top View 的展示
    private func setupTopView() {
        
        for item in topViewStack {
            topStack.addArrangedSubview(item)
        }
        
        if (topViewStack.count == 0) {
            csTopStackHeight.constant = 0
            return
        }
        csTopStackHeight.constant = csTopStackHeight.constant + cellManager.getTopStackViewHeight() * CGFloat(integerLiteral: topViewStack.count)
        
    }
    
    /// 设定 Bottom View 的展示
    private func setupBottomView() {
        for item in bottomViewStack {
            bottomStack.addArrangedSubview(item)
        }
        
        if (bottomViewStack.count == 0) {
            csBottomStackHeight.constant = 0
            return
        }
        
        csBottomStackHeight.constant = csBottomStackHeight.constant + cellManager.getBottomStackViewHeight() * CGFloat(integerLiteral: bottomViewStack.count)
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
        let user_info = UIView()
        
        let name_label = UILabel()
        name_label.text = username
        name_label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        let user_image = UIImageView(image: UIImage(systemName: "h.circle"))
        user_image.tintColor = UIColor.label
        user_image.contentMode = .scaleAspectFit
        user_info.addSubview(name_label)
        user_info.addSubview(user_image)

        user_image.snp.makeConstraints { make in
            make.centerYWithinMargins.equalToSuperview()
            make.height.equalTo(16)
            make.width.equalTo(16)
        }

        name_label.snp.makeConstraints { make in
            make.centerYWithinMargins.equalToSuperview()
            make.left.equalTo(user_image.snp.right).offset(8)
        }
        user_info.layer.cornerRadius = 11.0
        user_info.backgroundColor = UIColor.systemGray6

        return user_info
    }
    
    public func createUserEmail(username: String) -> UIView {
        let email_info = UIView()
        
        let sage_label = UILabel()
        sage_label.text = username
        sage_label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        let sage_image = UIImageView(image: UIImage(systemName: "at.circle"))
        sage_image.tintColor = UIColor.label
        sage_image.contentMode = .scaleAspectFit
        email_info.addSubview(sage_label)
        email_info.addSubview(sage_image)

        sage_image.snp.makeConstraints { make in
            make.centerYWithinMargins.equalToSuperview()
            make.height.equalTo(16)
            make.width.equalTo(16)
        }

        sage_label.snp.makeConstraints { make in
            make.centerYWithinMargins.equalToSuperview()
            make.left.equalTo(sage_image.snp.right).offset(8)
        }
        email_info.layer.cornerRadius = 11.0
        email_info.backgroundColor = UIColor.systemGray6

        return email_info
    }
    
    public func getTopStackViewHeight() -> CGFloat {
        return 14.0
    }
    
    
    public func createUserReplyLine(userPo: String, userContent: String) -> UIView {
        let user_reply_line = UIView()
        
        let user_label = UILabel()
        let content_label = UILabel()
        
        user_label.text = userPo
        content_label.text = userContent
        
        user_label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        content_label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        user_reply_line.addSubview(user_label)
        user_reply_line.addSubview(content_label)
        
        user_label.snp.makeConstraints { make in
            make.centerYWithinMargins.equalToSuperview()
            make.left.equalToSuperview().offset(2)
            make.height.equalTo(20)
            make.width.equalTo(70)
            
        }
        content_label.snp.makeConstraints { make in
            make.centerYWithinMargins.equalToSuperview()
            make.left.equalTo(user_label.snp.right).offset(8)
            make.right.equalToSuperview().offset(8)
        }
        
        return user_reply_line
    }
    
    public func createUserReplyCountView(count: Int) -> UIView {
        let sage_info = UIView()
        
        let sage_label = UILabel()
        sage_label.text = "还有 \(count) 条回复"
        sage_label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        let sage_image = UIImageView(image: UIImage(systemName: "quote.bubble"))
        sage_image.tintColor = UIColor.label
        sage_image.contentMode = .scaleAspectFit
        sage_info.addSubview(sage_label)
        sage_info.addSubview(sage_image)

        sage_image.snp.makeConstraints { make in
            make.centerYWithinMargins.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(20)
        }

        sage_label.snp.makeConstraints { make in
            make.centerYWithinMargins.equalToSuperview()
            make.left.equalTo(sage_image.snp.right).offset(8)
        }
        

        return sage_info
    }
    
    public func getBottomStackViewHeight() -> CGFloat {
        return 20.0
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
