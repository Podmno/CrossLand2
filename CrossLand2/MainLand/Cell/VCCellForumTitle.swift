//
//  VCCellForumTitle.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/13.
//

import UIKit
import AudioToolbox

class VCCellForumTitle: UIViewController {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var viewHolder: UIView!
    @IBOutlet weak var btnRule: UIButton!
    @IBOutlet weak var btnPost: UIButton!
    let labelMarquee = UILabel()
    
    
    let marqueeView = JXMarqueeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewContent()
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        appearViewContent()
    }
    
    private func setupViewContent() {

        // 为按钮添加动画
        btnPost.addTarget(self, action: #selector(touchDown), for: .touchDown)
        btnPost.addTarget(self, action: #selector(touchUp), for: .touchUpInside)
        btnPost.addTarget(self, action: #selector(touchUp), for: .touchUpOutside)
        
        btnRule.addTarget(self, action: #selector(touchDown), for: .touchDown)
        btnRule.addTarget(self, action: #selector(touchUp), for: .touchUpInside)
        btnRule.addTarget(self, action: #selector(touchUp), for: .touchUpOutside)

        
    }
    
    private func appearViewContent() {
        labelMarquee.text = "   此文本在正常情况下不因当被表示。如果你看到了此行文本，请将你的操作过程 / 设备信息 / 遇到的问题报告给 TRIStudio 以协助我们解决软件的错误。有关意见反馈及错误报告请点击主菜单的更多 > 设置 > 关于 > 问题报告，感谢你的协助与配合。你也可以访问 tri.studio.github.io TRIStudio 官方首页来获取帮助。"
        labelMarquee.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        viewHolder.addSubview(marqueeView)
        marqueeView.contentView = labelMarquee
        marqueeView.marqueeType = .left
        marqueeView.frame = viewHolder.bounds
        marqueeView.pointsPerFrame = 0.5
        
    }
    
    
    // MARK: - 外部 API：装载标题栏信息
    
    /// 设置大标题内容
    public func setLargeTitle(_ title: String) {
        
    }
    
    /// 设置滚动字体的内容
    public func setTitleInformation() {
        
        
    }
    
    // MARK: - 按钮的点击动画添加
    
    private var downStart = Date()
    private static var duration = 0.1 // changing to 0.5 makes it easier to test

    @objc func touchDown(_ button: UIButton) {
        downStart = Date() // Note when the touch-down happens
        
        UIView.animate(withDuration: Self.duration, delay: 0.0, options: .curveEaseIn) {
            button.transform = CGAffineTransform(scaleX: 0.93, y: 0.93)
            
        }
    }

    @objc func touchUp(_ button: UIButton) {
        // Delay the touch-up animation if needed
        let delay = max(downStart.timeIntervalSinceNow + Self.duration, 0.0)
        UIView.animate(withDuration: Self.duration, delay: delay, options: .curveEaseOut) {
            button.transform = .identity
        }
    }
    
    @IBAction func clickedPost(_ sender: Any) {
        print("> Go Post")
        //let soundID = SystemSoundID(kSystemSoundID_Vibrate)
        //let soundShort = SystemSoundID(1519)
        //AudioServicesPlaySystemSound(soundShort)
        buttonActiveAnimation(sender as! UIButton)
    }
    

    @IBAction func clickedNotice(_ sender: Any) {
        print("> Go Notice")
        
        //let soundShort = SystemSoundID(1519)
        //AudioServicesPlaySystemSound(soundShort)
    }
    
    
    // MARK: - 按钮按下后激活变色动画
    
    func buttonActiveAnimation(_ button: UIButton) {
        
        button.backgroundColor = UIColor.accent

        button.setTitleColor(UIColor.white, for: .normal)
        //button.imageView?.backgroundColor = UIColor.white
        //button.imageView?.tintColor = UIColor.white
        button.tintColor = UIColor.white
    }

}
