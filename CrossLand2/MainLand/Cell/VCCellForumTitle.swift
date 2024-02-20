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
    
    
    let labelMarquee = UILabel()
    
    let animationHelper = TRButtonAnimation()
    
    let marqueeView = JXMarqueeView()
    
    let titleAnimeText = UIHostingController(rootView: TUAnimeText(model: TUAnimeTextModel(text: "")))
    
    var viewHolder_height: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewContent()
        
        self.callBackCellHeightWillChange()
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
        
        //lbTitle.text = storageForumTitle
        
        labelMarquee.attributedText = self.storageForumInformationText
        labelMarquee.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        
        viewHolder.addSubview(marqueeView)
        marqueeView.contentView = labelMarquee
        marqueeView.marqueeType = .left
        marqueeView.pointsPerFrame = 0.5
        
        viewHolder.snp.makeConstraints { make in
            make.top.equalTo(self.viewTitle.snp.bottom)
            
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            self.viewHolder_height = make.height.equalTo(50).constraint
        }
        
        self.buttonStack.snp.makeConstraints { make in
            make.top.equalTo(self.viewHolder.snp.bottom).offset(60)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
        self.view.layoutIfNeeded()
        
        self.titleAnimeText.rootView.model.text = "综合版"
        
        self.callBackCellHeightDidChange()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //appearViewContent()
        

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Catalyst 专用：在 Frame 改变时改变跑马灯的位置
        //marqueeView.frame = viewHolder.bounds
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        marqueeView.frame = viewHolder.bounds
    }
    
    
    private func setupViewContent() {

        // 动画添加由 TRButtonAnimation 负责
        animationHelper.attachAnimationToButton(btnPost)
        animationHelper.attachAnimationToButton(btnRule)

    }
    
    private func appearViewContent() {


    }
    
    
    // MARK: - 外部 API：装载标题栏信息
    
    /// 此版面的名称
    var storageForumTitle: String = ""
    
    /// 此版面的公告内容 HTML
    var storageForumInformationHTML: String = ""
    
    var storageForumInformationText: NSAttributedString = NSAttributedString(string: "")
    
    /// 设置大标题内容
    public func setupLargeTitle(_ title: String) {
        storageForumTitle = title
    }
    
    
    /// 设置滚动字体的内容
    public func setupTitleInformation(_ contentHTML: String) {
        storageForumInformationHTML = contentHTML
        
        let attrFactory = TRAttributedFactory()
        storageForumInformationText = attrFactory.covertAttributedString(contentHTML) ?? NSAttributedString(string: "")
        
        labelMarquee.attributedText = storageForumInformationText
    }
    
    public func showDetailedTitleInformation(_ shown: Bool) {
        
        
        
        if (shown) {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                self.marqueeView.alpha = 0.0
                
                self.callBackCellHeightWillChange()

                self.titleAnimeText.rootView.model.text = "HelloWorld"
                self.viewHolder_height?.update(offset: 0)

                
                self.view.layoutIfNeeded()
                self.callBackCellHeightDidChange()
                
                
            }, completion:  {_ in 
                
            })
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut ,animations: {
                self.marqueeView.alpha = 1.0
                
                self.callBackCellHeightWillChange()
                
                self.viewHolder_height?.update(offset: 50)
                self.view.layoutIfNeeded()
                self.callBackCellHeightDidChange()
                
            }, completion: { _ in
                
            })
        }
        
        
        
    }
    
    /// Callback: 通知行高度发生了变化
    public var callBackCellHeightWillChange: () -> Void = {
        
    }
    
    public var callBackCellHeightDidChange: () -> Void = {
        
    }
    
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
        buttonActiveAnimation(sender as! UIButton, status: !btnNoticeActive)
        btnNoticeActive = !btnNoticeActive
        
        //let soundShort = SystemSoundID(1519)
        //AudioServicesPlaySystemSound(soundShort)
        
    }
    
    
    // MARK: - 按钮按下后激活变色动画
    
    func buttonActiveAnimation(_ button: UIButton, status: Bool) {
        
        if (status) {
            button.backgroundColor = UIColor.accent

            button.setTitleColor(UIColor.white, for: .normal)

            button.tintColor = UIColor.white
        } else {
            button.backgroundColor = UIColor.systemGray6

            button.setTitleColor(UIColor.label, for: .normal)

            button.tintColor = UIColor.label
        }
        
        
    }

}
