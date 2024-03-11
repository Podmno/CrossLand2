//
//  VCSpotlight.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/3/10.
//  Copyright © 2024 TRIStudio. All rights reserved.
//

import UIKit
import Hero

class VCSpotlight: UIViewController {

    @IBOutlet weak var bottomHolder: UIVisualEffectView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hero.isEnabled = true
        self.view.heroModifiers = []
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @IBAction func btnClickedClose(_ sender: Any) {
        //self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
        }

        let keyboardHeight = keyboardFrame.size.height
        let offset: CGFloat = 20 // 输入框或视图距离键盘的偏移量
        
        // 计算输入框或视图需要上移的距离
        let moveHeight = keyboardHeight + offset
        
        // 将输入框或视图向上移动
        UIView.animate(withDuration: 0.3) {
            self.view.frame = CGRect(x: 0, y: -moveHeight, width: self.view.bounds.width, height: self.view.bounds.height)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        // 将输入框或视图恢复原来的位置
        UIView.animate(withDuration: 0.3) {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }
    }


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class PaddingTextField: UITextField {

@IBInspectable var paddingLeft: CGFloat = 0
@IBInspectable var paddingRight: CGFloat = 0

    override func textRect(forBounds bounds: CGRect) -> CGRect {
    return CGRectMake(bounds.origin.x + paddingLeft, bounds.origin.y,
        bounds.size.width - paddingLeft - paddingRight, bounds.size.height);
}

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
}}
