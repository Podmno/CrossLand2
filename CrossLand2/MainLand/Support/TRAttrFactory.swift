//
//  TRAttrFactory.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/17.
//  Copyright © 2024 TRIStudio. All rights reserved.
//

import UIKit

class TRAttrFactory : NSObject {
    
    func covertAttributedString(_ str: String) -> NSMutableAttributedString? {
        let html_a_label_pattern = "<a+.*?>([\\s\\S]*?)|</a*?>"
        let regex = try! NSRegularExpression(pattern: html_a_label_pattern)
        var th_replace_result = regex.stringByReplacingMatches(in: str, range: NSRange(location: 0, length: str.count), withTemplate: "")
        
        th_replace_result = removeReturnInString(th_replace_result)
        
        let data = th_replace_result.data(using: .unicode)
        
        let systemFont = UIFont.systemFont(ofSize: 16)
        let attr = [NSAttributedString.Key.font: systemFont]
        
        if let attributedString = try? NSMutableAttributedString(data: data!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            attributedString.addAttributes(attr, range: NSRange(location: 0, length: attributedString.length))
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.label, range: NSRange(location: 0, length: attributedString.length))
            return attributedString
        } else {
            return nil
        }
        
    }
    
    /// 移除 HTML 标签中的 <br/>
    func removeReturnInString(_ str: String) -> String {
        let html_a_label_pattern = "<br />"
        let regex = try! NSRegularExpression(pattern: html_a_label_pattern)
        let th_replace_result = regex.stringByReplacingMatches(in: str, range: NSRange(location: 0, length: str.count), withTemplate: " ")
        return th_replace_result
    }
    
}
