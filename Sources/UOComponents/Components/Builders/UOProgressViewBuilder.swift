//
//  UOProgressViewBuilder.swift
//  UOComponents
//
//  Created by Ünsal Öner on 14.02.2026.
//

import UIKit

public final class UOProgressViewBuilder: UOBaseComponentBuilder<UIProgressView> {

    public init() {
        super.init(view: UIProgressView(progressViewStyle: .default))
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

public extension UOProgressViewBuilder {

    @discardableResult
    public func progress(_ value: Float) -> Self {
        view.progress = value
        return self
    }

    @discardableResult
    public func progressTintColor(_ color: UIColor) -> Self {
        view.progressTintColor = color
        return self
    }

    @discardableResult
    public func trackTintColor(_ color: UIColor) -> Self {
        view.trackTintColor = color
        return self
    }

    @discardableResult
    public func progressImage(_ image: UIImage?) -> Self {
        view.progressImage = image
        return self
    }

    @discardableResult
    public func trackImage(_ image: UIImage?) -> Self {
        view.trackImage = image
        return self
    }
}
