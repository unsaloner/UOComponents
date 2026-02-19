//
//  UOActivityIndicator+Styles.swift
//  UOComponents
//
//  Created by Ünsal Öner on 14.02.2026.
//

import UIKit

public extension UOActivityIndicatorBuilder {

    @discardableResult
    public func defaultStyle() -> Self {
        self
            .style(.medium)
            .color(UOColor.primary)
            .hidesWhenStopped(true)
            .startAnimating()
    }

    @discardableResult
    public func largeStyle() -> Self {
        self
            .style(.large)
            .color(UOColor.primary)
            .hidesWhenStopped(true)
            .startAnimating()
    }

    @discardableResult
    public func whiteStyle() -> Self {
        self
            .style(.medium)
            .color(.white)
            .hidesWhenStopped(true)
            .startAnimating()
    }
}
