//
//  CustomBlurView.swift
//  GlassMorphicCard-SwiftUI
//
//  Created by GOURAVM on 29/08/22.
//

import SwiftUI

struct CustomBlurView : UIViewRepresentable {
    var effect:UIBlurEffect.Style
    var onChange:(UIVisualEffectView)-> ()
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view  = UIVisualEffectView(effect: UIBlurEffect(style: effect))
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            onChange(uiView)
        }
    }
}


