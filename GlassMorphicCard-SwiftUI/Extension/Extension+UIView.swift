//
//  Extension+UIView.swift
//  GlassMorphicCard-SwiftUI
//
//  Created by GOURAVM on 29/08/22.
//

import UIKit

extension UIView {
    func subView(forClass:AnyClass?) -> UIView? {
        return subviews.first { view in
            type(of: view) == forClass
        }
    }
}
