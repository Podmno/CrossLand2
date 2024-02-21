//
//  VCCellForumTitle.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/13.
//

import UIKit
import SwiftUI
import SnapKit
import AudioToolbox

class VCCellForumTitle: UIViewController {

    @IBOutlet weak var viewTitle: UIView!
    
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var viewHolder: UIView!
    @IBOutlet weak var btnRule: UIButton!
    @IBOutlet weak var btnPost: UIButton!
    
    /// 滚动的 UILabel 内容
    let labelMarquee = UILabel()
    
    
    let labelMoreInfo = UITextView()
    
    let animationHelper = TRButtonAnimation()
    
    let marqueeView = JXMarqueeView()
    
    let titleAnimeText = UIHostingController(rootView: TUAnimeText(model: TUAnimeTextModel(text: "")))
    
    /// ViewHolder 的高度约束信息
    var viewHolder_height: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewContent()

        // Catalyst Accent Color Change Option
        NotificationCenter.default.addObserver(forName: .init("NSSystemColorsDidChangeNotification"), object: nil, queue: nil) { notification in
            self.animationHelper.buttonActiveAnimation(self.btnRule!, status: self.btnNoticeActive)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        // 此函数在 Catalyst 视图改变和 iPad 上分屏改变时均会触发
        super.viewWillLayoutSubviews()
        
        // Catalyst 专用：在 Frame 改变时改变跑马灯的位置
        //marqueeView.frame = viewHolder.bounds
        marqueeView.frame = viewHolder.bounds
        
        if (statusViewHolderExpanded) {
            self.callBackCellHeightWillChange()
            self.automaticAdjustViewHolderHeight(expanded: true)
            self.callBackCellHeightDidChange()
        }
    }
    
    
    private func setupViewContent() {
        self.callBackCellHeightWillChange()
        // 为按钮添加点击动画：动画添加由 TRButtonAnimation 负责
        animationHelper.attachAnimationToButton(btnPost)
        animationHelper.attachAnimationToButton(btnRule)
        
        labelMarquee.attributedText = self.storageForumInformationText
        labelMarquee.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        labelMoreInfo.attributedText = self.storageForumInformationTextWithReturn
        labelMoreInfo.isEditable = false
        labelMoreInfo.isScrollEnabled = false
        labelMoreInfo.showsVerticalScrollIndicator = false
        //labelMoreInfo.lineBreakMode = .byWordWrapping
        labelMoreInfo.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        //labelMoreInfo.numberOfLines = 0
        labelMoreInfo.alpha = 0.0
        
        self.titleAnimeText.rootView.model.text = "综合版"
        
        
        // Constraint Make
        
        self.viewTitle.addSubview(titleAnimeText.view)
        self.titleAnimeText.view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()

        }

        self.viewTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        

        marqueeView.removeFromSuperview()

        viewHolder.addSubview(marqueeView)
        viewHolder.addSubview(labelMoreInfo)
        
        
        marqueeView.contentView = labelMarquee
        marqueeView.marqueeType = .left
        marqueeView.pointsPerFrame = 0.5
        
        viewHolder.snp.makeConstraints { make in
            make.top.equalTo(self.viewTitle.snp.bottom).offset(10)
            
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            self.viewHolder_height = make.height.equalTo(20).constraint
        }
        
        self.labelMoreInfo.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        self.buttonStack.snp.makeConstraints { make in
            make.top.equalTo(self.viewHolder.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        
        
        self.view.layoutIfNeeded()
        self.callBackCellHeightDidChange()
    }
    
    
    /// 根据富文本计算高度
    /// - Parameter dataContent: NSAttributedString 内容
    /// - Returns: 应该的文本高度
    private func calcLabelMoreHeight(dataContent: NSAttributedString) -> CGFloat {
        
        //let rect = dataContent.boundingRect(with: CGSize(width: self.viewHolder.frame.width, height: .infinity), options: [.usesLineFragmentOrigin] , context:nil )
        let label_demo = UITextView()
        label_demo.attributedText = dataContent
        //label_demo.numberOfLines = 0
        //label_demo.lineBreakMode = .byWordWrapping
        label_demo.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        let rect = label_demo.sizeThatFits(CGSize(width: self.labelMoreInfo.frame.width, height: .infinity))
        
        return rect.height
    }
    
    /// 调整 ViewHolder 的高度信息。
    /// true: 展开 ViewHolder / false: 单行展示 ViewHolder
    /// - Parameter expanded: 是否展开 ViewHolder
    private func automaticAdjustViewHolderHeight(expanded: Bool) {
        if (expanded) {
            let repo_height = self.calcLabelMoreHeight(dataContent: self.storageForumInformationTextWithReturn)
            
            // FIXME: 在这个 offset 值设定为比较大的时候布局约束会报错，但是小的值却不会，很奇妙，而且 UI 上并没有什么问题似乎
            self.viewHolder_height?.update(offset: repo_height)

        } else {
            self.viewHolder_height?.update(offset: 20)
        }
        
    }
    
    
    // MARK: - 外部 API：装载标题栏信息
    
    /// 此版面的名称
    var storageForumTitle: String = ""
    
    /// 此版面的公告内容 HTML
    var storageForumInformationHTML: String = ""
    
    /// 保存的富文本信息，用于单行展示状态
    var storageForumInformationText: NSAttributedString = NSAttributedString(string: "")
    
    /// 保存的富文本信息，用于多行展示状态
    var storageForumInformationTextWithReturn: NSAttributedString = NSAttributedString(string: "")
    
    /// 当前的 ViewHolder 是否展开
    var statusViewHolderExpanded = false
    
    /// 设置大标题内容
    public func setupLargeTitle(_ title: String) {
        
        storageForumTitle = title
        self.titleAnimeText.rootView.model.text = storageForumTitle
        
    }
    
    
    /// 设置滚动字体的内容
    public func setupTitleInformation(_ contentHTML: String) {
        storageForumInformationHTML = contentHTML
        
        let attrFactory = TRAttributedFactory()
        storageForumInformationText = attrFactory.covertAttributedString(contentHTML, removeReturn: true) ?? NSAttributedString(string: "")
        storageForumInformationTextWithReturn = attrFactory.covertAttributedString(contentHTML, removeReturn: false) ?? NSAttributedString(string: "")
        
        labelMarquee.attributedText = storageForumInformationText
        labelMoreInfo.attributedText = storageForumInformationTextWithReturn
    }
    
    public func showDetailedTitleInformation(_ shown: Bool) {
        statusViewHolderExpanded = shown
        if (shown) {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.marqueeView.alpha = 0.0
                
                self.callBackCellHeightWillChange()
                self.titleAnimeText.rootView.model.text = "综合版1"
                self.labelMoreInfo.alpha = 1.0
                
                self.automaticAdjustViewHolderHeight(expanded: true)
                self.view.layoutIfNeeded()
                self.callBackCellHeightDidChange()
                
                
            }, completion:  {_ in 
                
            })
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut ,animations: {
                self.marqueeView.alpha = 1.0
                self.labelMoreInfo.alpha = 0.0
                self.callBackCellHeightWillChange()
                self.titleAnimeText.rootView.model.text = "Hello World"
                self.automaticAdjustViewHolderHeight(expanded: false)
                self.view.layoutIfNeeded()
                self.callBackCellHeightDidChange()
                
            }, completion: { _ in
                
            })
        }

    }
    
    /// Callback: 通知行高度发生了变化
    public var callBackCellHeightWillChange: () -> Void = { }

    /// Callback: 行高修改结束
    public var callBackCellHeightDidChange: () -> Void = { }
    
    // MARK: - 按钮按下操作

    @IBAction func clickedPost(_ sender: Any) {
        print("> Go Post")
        //let soundID = SystemSoundID(kSystemSoundID_Vibrate)
        //let soundShort = SystemSoundID(1519)
        //AudioServicesPlaySystemSound(soundShort)
        //buttonActiveAnimation(sender as! UIButton)
    }
    

    var btnNoticeActive = false
    @IBAction func clickedNotice(_ sender: Any) {

        if (!btnNoticeActive) {
            showDetailedTitleInformation(true)
        } else {
            showDetailedTitleInformation(false)
            
        }
        animationHelper.buttonActiveAnimation(sender as! UIButton, status: !btnNoticeActive)
        btnNoticeActive = !btnNoticeActive
        
        //let soundShort = SystemSoundID(1519)
        //AudioServicesPlaySystemSound(soundShort)
        
    }
    

    // 按钮激活动画交给 TRButtonAnimation 实现

}


