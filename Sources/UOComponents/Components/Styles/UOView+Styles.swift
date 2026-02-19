//
//  UOView+Styles.swift
//  UOComponents
//
//  Created by Ünsal Öner on 14.02.2026.
//

import UIKit
import SnapKit

public extension UOBaseComponentBuilder where View == UIView {
    
    public func dividerStyle(height: CGFloat = 1, color: UIColor = UOColor.divider) -> Self {
        backgroundColor(color)
        view.snp.makeConstraints { $0.height.equalTo(height) }
        return self
    }
    
    public func spacerStyle(height: CGFloat) -> Self {
        view.snp.makeConstraints { $0.height.equalTo(height) }
        return self
    }
}
