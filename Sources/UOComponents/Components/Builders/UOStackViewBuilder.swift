//
//  UOStackViewBuilder.swift
//  UOComponents
//
//  Created by Ünsal Öner on 12.02.2026.
//

import UIKit

public final class UOStackViewBuilder: UOBaseComponentBuilder<UIStackView> {

    public init() {
        super.init(view: UIStackView())
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

public extension UOStackViewBuilder {

    @discardableResult
    public func axis(_ axis: NSLayoutConstraint.Axis) -> Self {
        view.axis = axis
        return self
    }

    @discardableResult
    public func vertical(spacing: CGFloat = 8) -> Self {
        view.axis = .vertical
        view.spacing = spacing
        return self
    }

    @discardableResult
    public func horizontal(spacing: CGFloat = 8) -> Self {
        view.axis = .horizontal
        view.spacing = spacing
        return self
    }

    @discardableResult
    public func spacing(_ value: CGFloat) -> Self {
        view.spacing = value
        return self
    }

    @discardableResult
    public func alignment(_ alignment: UIStackView.Alignment) -> Self {
        view.alignment = alignment
        return self
    }

    @discardableResult
    public func distribution(_ distribution: UIStackView.Distribution) -> Self {
        view.distribution = distribution
        return self
    }
}

public extension UOStackViewBuilder {

    @discardableResult
    public func addArranged(_ view: UIView) -> Self {
        self.view.addArrangedSubview(view)
        return self
    }

    @discardableResult
    public func addArranged(_ views: UIView...) -> Self {
        views.forEach { self.view.addArrangedSubview($0) }
        return self
    }

    @discardableResult
    public func addArranged(_ views: [UIView]) -> Self {
        views.forEach { self.view.addArrangedSubview($0) }
        return self
    }

    @discardableResult
    public func insertArranged(_ view: UIView, at index: Int) -> Self {
        self.view.insertArrangedSubview(view, at: index)
        return self
    }

    @discardableResult
    public func setCustomSpacing(_ spacing: CGFloat, after arrangedSubview: UIView) -> Self {
        view.setCustomSpacing(spacing, after: arrangedSubview)
        return self
    }

    @discardableResult
    public func removeAllArrangedSubviews() -> Self {
        view.arrangedSubviews.forEach {
            view.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        return self
    }
}

public extension UOStackViewBuilder {

    @discardableResult
    public func padding(_ inset: CGFloat) -> Self {
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        return self
    }

    @discardableResult
    public func padding(_ insets: UIEdgeInsets) -> Self {
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = insets
        return self
    }
}
