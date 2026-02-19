//
//  UOSwitch+Styles.swift
//  UOComponents
//
//  Created by Ünsal Öner on 14.02.2026.
//

import UIKit

public extension UOSwitchBuilder {

    @discardableResult
    public func defaultStyle() -> Self {
        self
            .onTintColor(UOColor.primary)
    }

    @discardableResult
    public func accentStyle() -> Self {
        self
            .onTintColor(UOColor.accent)
    }

    @discardableResult
    public func destructiveStyle() -> Self {
        self
            .onTintColor(UOColor.error)
    }

    @discardableResult
    public func disabledStyle() -> Self {
        self
            .defaultStyle()
            .enabled(false)
            .alpha(0.5)
    }
}
