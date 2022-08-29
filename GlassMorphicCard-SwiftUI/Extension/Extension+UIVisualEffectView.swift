//
//  Extension+UIVisualEffectView.swift
//  GlassMorphicCard-SwiftUI
//
//  Created by GOURAVM on 29/08/22.
//

import UIKit

extension UIVisualEffectView {
    
    var backDrop: UIView? {
        return subView(forClass: NSClassFromString("_UIVisualEffectBackdropView"))
    }
    
    var gaussianBlur: NSObject?{
       return backDrop?.value(key: "filters", filter: "gaussianBlur")
    }
    
    var saturation:NSObject? {
        return backDrop?.value(key: "filters", filter: "colorSaturate")
    }
    
    var gaussianBlurRadius: CGFloat {
        get{
            gaussianBlur?.values?["InputRadius"] as? CGFloat ?? 0
        }
        set{
            gaussianBlur?.values?["inputRadius"] = newValue
            applyNewEffect()
        }
    }
    
    func applyNewEffect() {
        backDrop?.perform(Selector(("applyRequestedFilterEffects")))
    }
    
    var saturationAmount: CGFloat {
        get{
            saturation?.values?["InputAmount"] as? CGFloat ?? 0
        }
        set{
            saturation?.values?["InputAmount"] = newValue
            applyNewEffect()
        }
    }
   
}
