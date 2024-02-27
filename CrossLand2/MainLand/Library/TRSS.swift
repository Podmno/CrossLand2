//
//  TRSS.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/25.
//  Copyright © 2024 TRIStudio. All rights reserved.
//

import Foundation

/// TRI Signal & Slot Response Collection
class TRSS : NSObject {
    
    /// 信号：跳转至 Settings 页面
    func signalPresentSettings() {
        NotificationCenter.default.post(name: Notification.Name("landXPresentSettings"), object: nil)
    }
    
    /// 响应：跳转至 Settings 页面
    func slotPresentSettings(_ targetSelf: Any,_ targetFunction: Selector) {
        NotificationCenter.default.addObserver(targetSelf, selector: targetFunction, name: Notification.Name("landXPresentSettings"), object: nil)
    }
    
    /// 信号：跳转至 Settings 页面
    func signalPresentAcknowledgement() {
        NotificationCenter.default.post(name: Notification.Name("landXPresentAcknowledgement"), object: nil)
    }
    
    /// 响应：跳转至 Settings 页面
    func slotPresentAcknowledgement(_ targetSelf: Any,_ targetFunction: Selector) {
        NotificationCenter.default.addObserver(targetSelf, selector: targetFunction, name: Notification.Name("landXPresentAcknowledgement"), object: nil)
    }
    
    /// 信号：跳转至 Spotlight 页面
    func signalPresentSpotlightPage() {
        NotificationCenter.default.post(name: Notification.Name("landXPresentSpotlight"), object: nil)
    }
    
    /// 信号：跳转至 Spotlight 页面
    func slotPresentSpotlightPage(_ targetSelf: Any,_ targetFunction: Selector) {
        NotificationCenter.default.addObserver(targetSelf, selector: targetFunction, name: Notification.Name("landXPresentSpotlight"), object: nil)
    }
    
}
