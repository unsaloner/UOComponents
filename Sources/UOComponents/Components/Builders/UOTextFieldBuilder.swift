//
//  UOTextFieldBuilder.swift
//  UOComponents
//
//  Created by Ünsal Öner on 14.02.2026.
//

import UIKit

public final class UOTextFieldBuilder: UOBaseComponentBuilder<UITextField> {

    public init() {
        super.init(view: UITextField())
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Text & Appearance

public extension UOTextFieldBuilder {

    @discardableResult
    public func text(_ text: String?) -> Self {
        view.text = text
        return self
    }

    @discardableResult
    public func textColor(_ color: UIColor) -> Self {
        view.textColor = color
        return self
    }

    @discardableResult
    public func font(_ font: UIFont) -> Self {
        view.font = font
        return self
    }

    @discardableResult
    public func alignment(_ alignment: NSTextAlignment) -> Self {
        view.textAlignment = alignment
        return self
    }

    @discardableResult
    public func placeholder(_ placeholder: String) -> Self {
        view.placeholder = placeholder
        return self
    }

    @discardableResult
    public func attributedPlaceholder(text: String, font: UIFont, color: UIColor) -> Self {
        view.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [.foregroundColor: color, .font: font]
        )
        return self
    }

    @discardableResult
    public func borderStyle(_ style: UITextField.BorderStyle) -> Self {
        view.borderStyle = style
        return self
    }
}

// MARK: - Behavior

public extension UOTextFieldBuilder {

    @discardableResult
    public func isSecureTextEntry(_ isSecure: Bool) -> Self {
        view.isSecureTextEntry = isSecure
        return self
    }

    @discardableResult
    public func keyboardType(_ type: UIKeyboardType) -> Self {
        view.keyboardType = type
        return self
    }

    @discardableResult
    public func returnKeyType(_ type: UIReturnKeyType) -> Self {
        view.returnKeyType = type
        return self
    }

    @discardableResult
    public func autocapitalizationType(_ type: UITextAutocapitalizationType) -> Self {
        view.autocapitalizationType = type
        return self
    }

    @discardableResult
    public func autocorrectionType(_ type: UITextAutocorrectionType) -> Self {
        view.autocorrectionType = type
        return self
    }

    @discardableResult
    public func textContentType(_ type: UITextContentType) -> Self {
        view.textContentType = type
        return self
    }

    @discardableResult
    public func clearButtonMode(_ mode: UITextField.ViewMode) -> Self {
        view.clearButtonMode = mode
        return self
    }

    @discardableResult
    public func enabled(_ enabled: Bool) -> Self {
        view.isEnabled = enabled
        return self
    }
}

// MARK: - Padding & Views

public extension UOTextFieldBuilder {

    @discardableResult
    public func leftPadding(_ amount: CGFloat) -> Self {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: 0))
        view.leftView = paddingView
        view.leftViewMode = .always
        return self
    }

    @discardableResult
    public func rightPadding(_ amount: CGFloat) -> Self {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: 0))
        view.rightView = paddingView
        view.rightViewMode = .always
        return self
    }

    @discardableResult
    public func leftView(_ leftView: UIView, mode: UITextField.ViewMode = .always) -> Self {
        view.leftView = leftView
        view.leftViewMode = mode
        return self
    }

    @discardableResult
    public func rightView(_ rightView: UIView, mode: UITextField.ViewMode = .always) -> Self {
        view.rightView = rightView
        view.rightViewMode = mode
        return self
    }
}
