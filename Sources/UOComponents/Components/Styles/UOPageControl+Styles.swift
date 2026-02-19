//
//  UOPageControl+Styles.swift
//  UOComponents
//
//  Created by Ünsal Öner on 16.02.2026.
//

import UIKit

public extension UOPageControlBuilder {

    @discardableResult
    public func defaultStyle() -> Self {
        self
            .activeColor(UOColor.primary)
            .inactiveColor(UOColor.border)
            .dotSize(8)
            .activeDotWidth(32)
            .spacing(8)
    }
}
