//
//  UOProgressView+Styles.swift
//  UOComponents
//
//  Created by Ünsal Öner on 14.02.2026.
//

import UIKit
import SnapKit

public extension UOProgressViewBuilder {

    @discardableResult
    public func defaultStyle() -> Self {
        self
            .progressTintColor(UOColor.primary)
            .trackTintColor(UOColor.border)
            .cornerRadius(2)
    }

    @discardableResult
    public func accentStyle() -> Self {
        self
            .progressTintColor(UOColor.accent)
            .trackTintColor(UOColor.border)
            .cornerRadius(2)
    }

    @discardableResult
    public func successStyle() -> Self {
        self
            .progressTintColor(UOColor.success)
            .trackTintColor(UOColor.border)
            .cornerRadius(2)
    }

    @discardableResult
    public func warningStyle() -> Self {
        self
            .progressTintColor(UOColor.warning)
            .trackTintColor(UOColor.border)
            .cornerRadius(2)
    }

    @discardableResult
    public func thickStyle(height: CGFloat = 8) -> Self {
        self
            .defaultStyle()
            .cornerRadius(height / 2)
            .configure { view in
                view.snp.makeConstraints { $0.height.equalTo(height) }
            }
    }
}
