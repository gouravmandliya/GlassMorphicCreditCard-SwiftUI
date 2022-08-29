//
//  Extension+NSObject.swift
//  GlassMorphicCard-SwiftUI
//
//  Created by GOURAVM on 29/08/22.
//

import Foundation

extension NSObject {
    
    var values:[String:Any]? {
        get {
            return value(forKeyPath:"requestedValues") as? [String:Any]
        }
        set {
             setValue(newValue, forKeyPath: "requestedValues")
        }
    }
    
    func value(key:String,filter:String)->NSObject? {
        (value(forKey: key) as? [NSObject])?.first(where: { obj in
            return obj.value(forKeyPath: "filterType") as? String == filter
        })
    }
}
