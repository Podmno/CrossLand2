//
//  TUAnimeText.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/20.
//  Copyright © 2024 TRIStudio. All rights reserved.
//

import SwiftUI

struct TUTitleEffect: ATTextAnimateEffect {
    
    var data: ATElementData
    var userInfo: Any?
    
    var color: Color = .accentColor
    
    public init(_ data: ATElementData, _ userInfo: Any?) {
        self.data = data
        self.userInfo = userInfo
        if let info = userInfo as? [String: Any] {
            color = info["color"] as! Color
        }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .opacity(data.value)
            content
                .foregroundColor(color)
                .opacity(data.invValue)
        }
        .animation(.spring(response: 0.9, dampingFraction: 0.6, blendDuration: 0.4).delay(Double(data.index) * 0.06), value: data.value)
        .scaleEffect(data.scale, anchor: .leading)
        .animation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.4).delay(Double(data.index) * 0.06), value: data.value)
    }
}


class TUAnimeTextModel: ObservableObject {
    @Published var text: String = ""
    
    init(text: String) {
            withAnimation(.linear(duration: 0.3)) {
                self.text = text
            }
            
        }
}

struct TUAnimeText: View {
    
    @ObservedObject var model: TUAnimeTextModel

    /// The type used to split text.
    @State var type: ATUnitType = .letters

    /// Custom user info for the effect.
    @State var userInfo: Any? = nil
    
    var body: some View {
        
        AnimateText<TUTitleEffect>($model.text, type: type, userInfo: userInfo)
            .font(.system(size: 30, weight: .bold))
            
    }
}

#Preview {
    TUAnimeText( model: TUAnimeTextModel(text: "Demo"))
}
