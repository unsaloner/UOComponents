//
//  UOActivityIndicatorBuilder.swift
//  UOComponents
//
//  Created by Ünsal Öner on 14.02.2026.
//

import UIKit

public final class UOActivityIndicatorBuilder: UOBaseComponentBuilder<UIActivityIndicatorView> {

    public init(style: UIActivityIndicatorView.Style = .medium) {
        super.init(view: UIActivityIndicatorView(style: style))
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

public extension UOActivityIndicatorBuilder {

    @discardableResult
    public func style(_ style: UIActivityIndicatorView.Style) -> Self {
        view.style = style
        return self
    }

    @discardableResult
    public func color(_ color: UIColor) -> Self {
        view.color = color
        return self
    }

    @discardableResult
    public func hidesWhenStopped(_ hides: Bool) -> Self {
        view.hidesWhenStopped = hides
        return self
    }

    @discardableResult
    public func startAnimating() -> Self {
        view.startAnimating()
        return self
    }
}
