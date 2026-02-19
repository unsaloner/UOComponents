//
//  UOSegmentedControlBuilder.swift
//  UOComponents
//
//  Created by Ünsal Öner on 14.02.2026.
//

import UIKit

public final class UOSegmentedControlBuilder: UOBaseComponentBuilder<UISegmentedControl> {

    public init(items: [Any]? = nil) {
        super.init(view: UISegmentedControl(items: items))
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

public extension UOSegmentedControlBuilder {

    @discardableResult
    public func selectedIndex(_ index: Int) -> Self {
        view.selectedSegmentIndex = index
        return self
    }

    @discardableResult
    public func selectedTintColor(_ color: UIColor) -> Self {
        view.selectedSegmentTintColor = color
        return self
    }

    @discardableResult
    public func normalTextAttributes(_ attributes: [NSAttributedString.Key: Any]) -> Self {
        view.setTitleTextAttributes(attributes, for: .normal)
        return self
    }

    @discardableResult
    public func selectedTextAttributes(_ attributes: [NSAttributedString.Key: Any]) -> Self {
        view.setTitleTextAttributes(attributes, for: .selected)
        return self
    }

    @discardableResult
    public func enabled(_ enabled: Bool) -> Self {
        view.isEnabled = enabled
        return self
    }

    @discardableResult
    public func onValueChanged(_ target: Any?, action: Selector) -> Self {
        view.addTarget(target, action: action, for: .valueChanged)
        return self
    }
}
