//
//  UOTextView+Styles.swift
//  UOComponents
//
//  Created by Ünsal Öner on 14.02.2026.
//

import UIKit

public extension UOTextViewBuilder {

    @discardableResult
    public func defaultStyle() -> Self {
        self
            .font(UOFont.body())
            .textColor(UOColor.textPrimary)
            .backgroundColor(UOColor.surface)
            .cornerRadius(12)
            .border(width: 1, color: UOColor.border)
    }

    @discardableResult
    public func readOnlyStyle() -> Self {
        self
            .defaultStyle()
            .editable(false)
            .selectable(true)
            .dataDetectorTypes(.all)
    }

    @discardableResult
    public func disabledStyle() -> Self {
        self
            .defaultStyle()
            .editable(false)
            .selectable(false)
            .alpha(0.5)
    }
}
