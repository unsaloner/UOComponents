//
//  UOImageViewBuilder.swift
//  UOComponents
//
//  Created by Ünsal Öner on 12.02.2026.
//

import UIKit

public final class UOImageViewBuilder: UOBaseComponentBuilder<UIImageView> {

    public init() {
        super.init(view: UIImageView())
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
    }
}

// MARK: - Image Properties

public extension UOImageViewBuilder {

    @discardableResult
    public func image(_ image: UIImage?) -> Self {
        view.image = image
        return self
    }

    @discardableResult
    public func image(named name: String) -> Self {
        view.image = UIImage(named: name)
        return self
    }

    @discardableResult
    public func image(systemName: String) -> Self {
        view.image = UIImage(systemName: systemName)
        return self
    }

    @discardableResult
    public func highlightedImage(_ image: UIImage?) -> Self {
        view.highlightedImage = image
        return self
    }
}

// MARK: - Content & Rendering

public extension UOImageViewBuilder {

    @discardableResult
    public func aspectFit() -> Self {
        view.contentMode = .scaleAspectFit
        return self
    }

    @discardableResult
    public func aspectFill() -> Self {
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return self
    }

    @discardableResult
    public func renderingMode(_ mode: UIImage.RenderingMode) -> Self {
        view.image = view.image?.withRenderingMode(mode)
        return self
    }

    @discardableResult
    public func templateMode() -> Self {
        view.image = view.image?.withRenderingMode(.alwaysTemplate)
        return self
    }
}

// MARK: - Shape

public extension UOImageViewBuilder {

    @discardableResult
    public func circular() -> Self {
        view.clipsToBounds = true
        view.layer.cornerRadius = min(view.bounds.width, view.bounds.height) / 2
        return self
    }

    @discardableResult
    public func size(_ size: CGFloat) -> Self {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: size),
            view.heightAnchor.constraint(equalToConstant: size)
        ])
        return self
    }

    @discardableResult
    public func size(width: CGFloat, height: CGFloat) -> Self {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: width),
            view.heightAnchor.constraint(equalToConstant: height)
        ])
        return self
    }
}
