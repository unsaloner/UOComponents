//
//  UIView+.swift
//  UOComponents
//
//  Created by Ünsal Öner on 14.02.2026.
//

import UIKit

public extension UIView {
    static func builder() -> UOBaseComponentBuilder<UIView> {
        UOBaseComponentBuilder(view: UIView())
    }
}
