//
//  UOTextField+Styles.swift
//  UOComponents
//
//  Created by Ünsal Öner on 14.02.2026.
//

import UIKit

public extension UOTextFieldBuilder {

    // MARK: - Default

    @discardableResult
    public func defaultStyle() -> Self {
        self
            .font(UOFont.body())
            .textColor(UOColor.textPrimary)
            .backgroundColor(UOColor.surface)
            .cornerRadius(12)
            .leftPadding(16)
            .rightPadding(16)
            .border(width: 1, color: UOColor.border)
            .attributedPlaceholder(text: "", font: UOFont.body(), color: UOColor.textMuted)
            .autocorrectionType(.no)
    }

    // MARK: - Search

    @discardableResult
    public func searchStyle() -> Self {
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        let icon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        icon.tintColor = UOColor.textMuted
        icon.contentMode = .scaleAspectFit
        icon.frame = CGRect(x: 12, y: 0, width: 20, height: 20)
        iconView.addSubview(icon)

        return self
            .font(UOFont.body())
            .textColor(UOColor.textPrimary)
            .backgroundColor(UOColor.surface)
            .cornerRadius(12)
            .border(width: 1, color: UOColor.border)
            .leftView(iconView)
            .rightPadding(16)
            .placeholder("Search...")
            .clearButtonMode(.whileEditing)
            .returnKeyType(.search)
            .autocorrectionType(.no)
    }

    // MARK: - Secure (Password)

    @discardableResult
    public func secureStyle() -> Self {
        self
            .defaultStyle()
            .isSecureTextEntry(true)
            .textContentType(.password)
            .placeholder("Password")
            .clearButtonMode(.whileEditing)
    }

    // MARK: - Email

    @discardableResult
    public func emailStyle() -> Self {
        self
            .defaultStyle()
            .keyboardType(.emailAddress)
            .autocapitalizationType(.none)
            .autocorrectionType(.no)
            .textContentType(.emailAddress)
            .placeholder("email@example.com")
    }

    // MARK: - Underlined (Minimal)

    @discardableResult
    public func underlinedStyle() -> Self {
        self
            .font(UOFont.body())
            .textColor(UOColor.textPrimary)
            .borderStyle(.none)
            .leftPadding(4)
            .autocorrectionType(.no)
            .configure { field in
                let line = UIView()
                line.backgroundColor = UOColor.border
                line.translatesAutoresizingMaskIntoConstraints = false
                field.addSubview(line)
                NSLayoutConstraint.activate([
                    line.leadingAnchor.constraint(equalTo: field.leadingAnchor),
                    line.trailingAnchor.constraint(equalTo: field.trailingAnchor),
                    line.bottomAnchor.constraint(equalTo: field.bottomAnchor),
                    line.heightAnchor.constraint(equalToConstant: 1)
                ])
            }
    }

    // MARK: - Disabled

    @discardableResult
    public func disabledStyle() -> Self {
        self
            .defaultStyle()
            .alpha(0.5)
            .isUserInteractionEnabled(false)
    }
}
