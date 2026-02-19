//
//  UOImageView+Styles.swift
//  UOComponents
//
//  Created by Ünsal Öner on 12.02.2026.
//

import UIKit

public extension UOImageViewBuilder {

    @discardableResult
    public func avatarStyle(size: CGFloat = 48) -> Self {
        self
            .size(size)
            .aspectFill()
            .cornerRadius(size / 2)
    }

    @discardableResult
    public func iconStyle(size: CGFloat = 24) -> Self {
        self
            .size(size)
            .templateMode()
            .tintColor(UOColor.textSecondary)
            .aspectFit()
    }

    @discardableResult
    public func bannerStyle() -> Self {
        self
            .aspectFill()
            .cornerRadius(12)
    }

    @discardableResult
    public func thumbnailStyle(size: CGFloat = 64) -> Self {
        self
            .size(size)
            .aspectFill()
            .cornerRadius(8)
    }
}
