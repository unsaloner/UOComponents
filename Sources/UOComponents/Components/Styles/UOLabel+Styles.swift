//
//  UOLabel+Styles.swift
//  UOComponents
//
//  Created by Ünsal Öner on 12.02.2026.
//

import UIKit

public extension UOLabelBuilder {

    @discardableResult
    public func largeTitleStyle() -> Self {
        self
            .font(UOFont.largeTitle())
            .textColor(UOColor.textPrimary)
    }

    @discardableResult
    public func titleStyle() -> Self {
        self
            .font(UOFont.title())
            .textColor(UOColor.textPrimary)
    }

    @discardableResult
    public func subtitleStyle() -> Self {
        self
            .font(UOFont.subtitle())
            .textColor(UOColor.textSecondary)
    }

    @discardableResult
    public func bodyStyle() -> Self {
        self
            .font(UOFont.body())
            .textColor(UOColor.textPrimary)
    }

    @discardableResult
    public func captionStyle() -> Self {
        self
            .font(UOFont.caption())
            .textColor(UOColor.textMuted)
    }

    @discardableResult
    public func headlineStyle() -> Self {
        self
            .font(UOFont.bodyMedium())
            .textColor(UOColor.textPrimary)
    }

    @discardableResult
    public func footnoteStyle() -> Self {
        self
            .font(UOFont.caption(12))
            .textColor(UOColor.textMuted)
    }

    @discardableResult
    public func errorStyle() -> Self {
        self
            .font(UOFont.body())
            .textColor(UOColor.error)
    }

    @discardableResult
    public func successStyle() -> Self {
        self
            .font(UOFont.body())
            .textColor(UOColor.success)
    }

    @discardableResult
    public func warningStyle() -> Self {
        self
            .font(UOFont.body())
            .textColor(UOColor.warning)
    }

    @discardableResult
    public func linkStyle() -> Self {
        self
            .font(UOFont.body())
            .textColor(UOColor.primary)
    }

    @discardableResult
    public func badgeStyle() -> Self {
        self
            .font(UOFont.caption(11))
            .textColor(.white)
            .backgroundColor(UOColor.error)
            .alignment(.center)
            .cornerRadius(8)
            .clipsToBounds(true)
    }
}
