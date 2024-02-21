//
//  TRButtonAnime.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/16.
//  Copyright © 2024 TRIStudio. All rights reserved.
//

import UIKit

class TRButtonAnimation : NSObject {
    
    private var downStart = Date()
    private static var duration = 0.1

    public func attachAnimationToButton(_ button: UIButton) {
        
        button.addTarget(self, action: #selector(touchDown), for: .touchDown)
        button.addTarget(self, action: #selector(touchUp), for: .touchUpInside)
        button.addTarget(self, action: #selector(touchUp), for: .touchUpOutside)
    }
    
    public func buttonActiveAnimation(_ button: UIButton, status: Bool) {
        if (status) {
            button.backgroundColor = UIColor.accent
        #if targetEnvironment(macCatalyst)
            button.backgroundColor = UIColor.kjy_controlAccentColor
        #endif

            button.setTitleColor(UIColor.white, for: .normal)

            button.tintColor = UIColor.white
        } else {
            button.backgroundColor = UIColor.systemGray6

            button.setTitleColor(UIColor.label, for: .normal)

            button.tintColor = UIColor.label
        }
    }
    
    
    @objc func touchDown(_ button: UIButton) {
        downStart = Date()

        UIView.animate(withDuration: Self.duration, delay: 0.0, options: .curveEaseInOut) {
            
           
            button.layer.shadowColor = UIColor.systemGray.cgColor
            button.layer.shadowRadius = 10.0
            button.layer.shadowOpacity = 0.2
            button.layer.shadowOffset = CGSize(width: 0, height: 5)
            button.transform = CGAffineTransform(scaleX: 0.93, y: 0.93)
            
        }
    }

    @objc func touchUp(_ button: UIButton) {
        // Delay the touch-up animation if needed

        let delay = max(downStart.timeIntervalSinceNow + Self.duration, 0.0)
        UIView.animate(withDuration: Self.duration, delay: delay, options: .curveEaseInOut) {
            
            button.layer.shadowColor = UIColor.systemGray.cgColor
            button.layer.shadowRadius = 0.0
            button.layer.shadowOpacity = 0.0
            button.layer.masksToBounds = false
            button.transform = .identity
        }
    }
    
    
}

extension UIColor {
    #if targetEnvironment(macCatalyst)
    static var kjy_controlAccentColor: UIColor! { UIColor.value(forKey: "controlAccentColor") as? UIColor }
    #endif
}
