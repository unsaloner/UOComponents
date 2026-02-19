//
//  UOSwitchBuilder.swift
//  UOComponents
//
//  Created by Ünsal Öner on 14.02.2026.
//

import UIKit

public final class UOSwitchBuilder: UOBaseComponentBuilder<UISwitch> {

    public init() {
        super.init(view: UISwitch())
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

public extension UOSwitchBuilder {

    @discardableResult
    public func isOn(_ on: Bool) -> Self {
        view.isOn = on
        return self
    }

    @discardableResult
    public func onTintColor(_ color: UIColor) -> Self {
        view.onTintColor = color
        return self
    }

    @discardableResult
    public func thumbTintColor(_ color: UIColor) -> Self {
        view.thumbTintColor = color
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
