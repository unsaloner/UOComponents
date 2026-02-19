//
//  UOBaseComponentBuilder.swift
//  UOComponents
//
//  Created by Ünsal Öner on 12.02.2026.
//

import UIKit

public protocol UOBuildable {
    associatedtype Component
    func build() -> Component
}

public class UOBaseComponentBuilder<View: UIView>: UOBuildable {

    public let view: View

    public init(view: View) {
        self.view = view
    }

    public func build() -> View {
        view
    }

    @discardableResult
    public func configure(_ block: (View) -> Void) -> Self {
        block(view)
        return self
    }

    @discardableResult
    public func backgroundColor(_ color: UIColor) -> Self {
        view.backgroundColor = color
        return self
    }

    @discardableResult
    public func tintColor(_ color: UIColor) -> Self {
        view.tintColor = color
        return self
    }

    @discardableResult
    public func alpha(_ value: CGFloat) -> Self {
        view.alpha = value
        return self
    }

    @discardableResult
    public func hidden(_ hidden: Bool) -> Self {
        view.isHidden = hidden
        return self
    }

    @discardableResult
    public func cornerRadius(_ radius: CGFloat) -> Self {
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
        return self
    }

    @discardableResult
    public func clipsToBounds(_ clips: Bool = true) -> Self {
        view.clipsToBounds = clips
        return self
    }

    @discardableResult
    public func border(width: CGFloat, color: UIColor) -> Self {
        view.layer.borderWidth = width
        view.layer.borderColor = color.cgColor
        return self
    }

    @discardableResult
    public func shadow(color: UIColor = .black,
                opacity: Float = 0.2,
                offset: CGSize = .init(width: 0, height: 2),
                radius: CGFloat = 4) -> Self {
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = offset
        view.layer.shadowRadius = radius
        view.layer.masksToBounds = false
        return self
    }

    @discardableResult
    public func isUserInteractionEnabled(_ enabled: Bool) -> Self {
        view.isUserInteractionEnabled = enabled
        return self
    }

    @discardableResult
    public func translatesAutoresizingMask(_ translates: Bool) -> Self {
        view.translatesAutoresizingMaskIntoConstraints = translates
        return self
    }

    @discardableResult
    public func contentHuggingPriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        view.setContentHuggingPriority(priority, for: axis)
        return self
    }

    @discardableResult
    public func contentCompressionResistancePriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        view.setContentCompressionResistancePriority(priority, for: axis)
        return self
    }

    @discardableResult
    public func tag(_ tag: Int) -> Self {
        view.tag = tag
        return self
    }

    @discardableResult
    public func accessibilityIdentifier(_ identifier: String) -> Self {
        view.accessibilityIdentifier = identifier
        return self
    }

    @discardableResult
    public func contentMode(_ mode: UIView.ContentMode) -> Self {
        view.contentMode = mode
        return self
    }
}
