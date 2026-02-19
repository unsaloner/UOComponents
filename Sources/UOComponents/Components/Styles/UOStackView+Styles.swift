//
//  UOStackView+Styles.swift
//  UOComponents
//
//  Created by Ünsal Öner on 12.02.2026.
//

import UIKit

public extension UOStackViewBuilder {

    @discardableResult
    public func cardStyle() -> Self {
        self
            .backgroundColor(UOColor.card)
            .cornerRadius(16)
            .padding(16)
    }

    @discardableResult
    public func sectionStyle() -> Self {
        self
            .vertical(spacing: 12)
            .alignment(.fill)
    }
}
