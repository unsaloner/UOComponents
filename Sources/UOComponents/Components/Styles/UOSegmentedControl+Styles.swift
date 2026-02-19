//
//  UOSegmentedControl+Styles.swift
//  UOComponents
//
//  Created by Ünsal Öner on 14.02.2026.
//

import UIKit

public extension UOSegmentedControlBuilder {

    @discardableResult
    public func defaultStyle() -> Self {
        self
            .selectedTintColor(UOColor.primary)
            .normalTextAttributes([
                .foregroundColor: UOColor.textSecondary,
                .font: UOFont.body()
            ])
            .selectedTextAttributes([
                .foregroundColor: UIColor.white,
                .font: UOFont.bodyMedium()
            ])
            .selectedIndex(0)
    }

    @discardableResult
    public func accentStyle() -> Self {
        self
            .selectedTintColor(UOColor.accent)
            .normalTextAttributes([
                .foregroundColor: UOColor.textSecondary,
                .font: UOFont.body()
            ])
            .selectedTextAttributes([
                .foregroundColor: UIColor.white,
                .font: UOFont.bodyMedium()
            ])
            .selectedIndex(0)
    }

    @discardableResult
    public func disabledStyle() -> Self {
        self
            .defaultStyle()
            .enabled(false)
            .alpha(0.5)
    }
}
