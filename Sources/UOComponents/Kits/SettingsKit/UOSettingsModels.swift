//
//  UOSettingsModels.swift
//  UOComponents
//
//  Created by Ünsal Öner on 16.02.2026.
//

import UIKit

// MARK: - Item Type

public enum UOSettingsItemType: Int, CaseIterable {
    case rateApp = 0
    case shareApp
    case contactSupport
    case termsOfService
    case privacyPolicy
    case restorePurchases
    case deleteAccount
    case copyUserId
}

// MARK: - Section

public struct UOSettingsSection {
    public let title: String
    public let items: [UOSettingsItem]

    public init(title: String, items: [UOSettingsItem]) {
        self.title = title
        self.items = items
    }
}

// MARK: - Item

public struct UOSettingsItem {
    public let type: UOSettingsItemType
    public let title: String
    public let iconName: String
    public let isDestructive: Bool

    public init(
        type: UOSettingsItemType,
        title: String,
        iconName: String,
        isDestructive: Bool = false
    ) {
        self.type = type
        self.title = title
        self.iconName = iconName
        self.isDestructive = isDestructive
    }
}

// MARK: - Footer

public struct UOSettingsFooter {
    public let versionText: String?
    public let userIdText: String?
    public let showCopyButton: Bool

    public init(
        versionText: String? = nil,
        userIdText: String? = nil,
        showCopyButton: Bool = false
    ) {
        self.versionText = versionText
        self.userIdText = userIdText
        self.showCopyButton = showCopyButton
    }
}

// MARK: - Config

public struct UOSettingsConfig {
    public let headerTitle: String
    public let sections: [UOSettingsSection]
    public let footer: UOSettingsFooter?
    public let termsURL: String?
    public let termsTitle: String?
    public let privacyURL: String?
    public let privacyTitle: String?
    public let supportEmail: String?

    public init(
        headerTitle: String,
        sections: [UOSettingsSection],
        footer: UOSettingsFooter? = nil,
        termsURL: String? = nil,
        termsTitle: String? = nil,
        privacyURL: String? = nil,
        privacyTitle: String? = nil,
        supportEmail: String? = nil
    ) {
        self.headerTitle = headerTitle
        self.sections = sections
        self.footer = footer
        self.termsURL = termsURL
        self.termsTitle = termsTitle
        self.privacyURL = privacyURL
        self.privacyTitle = privacyTitle
        self.supportEmail = supportEmail
    }
}

// MARK: - Style

public struct UOSettingsStyle {

    public struct Header {
        public let backgroundColor: UIColor
        public let titleFont: UIFont
        public let titleColor: UIColor
        public let backButtonTint: UIColor

        public init(
            backgroundColor: UIColor,
            titleFont: UIFont,
            titleColor: UIColor,
            backButtonTint: UIColor
        ) {
            self.backgroundColor = backgroundColor
            self.titleFont = titleFont
            self.titleColor = titleColor
            self.backButtonTint = backButtonTint
        }
    }

    public struct Section {
        public let titleFont: UIFont
        public let titleColor: UIColor

        public init(titleFont: UIFont, titleColor: UIColor) {
            self.titleFont = titleFont
            self.titleColor = titleColor
        }
    }

    public struct Item {
        public let backgroundColor: UIColor
        public let titleFont: UIFont
        public let titleColor: UIColor
        public let iconTint: UIColor
        public let destructiveColor: UIColor

        public init(
            backgroundColor: UIColor,
            titleFont: UIFont,
            titleColor: UIColor,
            iconTint: UIColor,
            destructiveColor: UIColor
        ) {
            self.backgroundColor = backgroundColor
            self.titleFont = titleFont
            self.titleColor = titleColor
            self.iconTint = iconTint
            self.destructiveColor = destructiveColor
        }
    }

    public struct CopyButtonStyle {
        public let font: UIFont
        public let color: UIColor
        public let backgroundColor: UIColor

        public init(font: UIFont, color: UIColor, backgroundColor: UIColor) {
            self.font = font
            self.color = color
            self.backgroundColor = backgroundColor
        }
    }

    public struct Footer {
        public let versionFont: UIFont
        public let versionColor: UIColor
        public let userIdFont: UIFont
        public let userIdColor: UIColor
        public let copyButtonStyle: CopyButtonStyle

        public init(
            versionFont: UIFont,
            versionColor: UIColor,
            userIdFont: UIFont,
            userIdColor: UIColor,
            copyButtonStyle: CopyButtonStyle
        ) {
            self.versionFont = versionFont
            self.versionColor = versionColor
            self.userIdFont = userIdFont
            self.userIdColor = userIdColor
            self.copyButtonStyle = copyButtonStyle
        }
    }

    public let header: Header
    public let section: Section
    public let item: Item
    public let footer: Footer

    public init(
        header: Header,
        section: Section,
        item: Item,
        footer: Footer
    ) {
        self.header = header
        self.section = section
        self.item = item
        self.footer = footer
    }

    public static func `default`() -> UOSettingsStyle {
        UOSettingsStyle(
            header: Header(
                backgroundColor: UOColor.background,
                titleFont: UOFont.title(20),
                titleColor: UOColor.textPrimary,
                backButtonTint: UOColor.textPrimary
            ),
            section: Section(
                titleFont: UOFont.button(12),
                titleColor: UOColor.textMuted
            ),
            item: Item(
                backgroundColor: UOColor.surface,
                titleFont: UOFont.subtitle(16),
                titleColor: UOColor.textPrimary,
                iconTint: UOColor.primary,
                destructiveColor: UOColor.error
            ),
            footer: Footer(
                versionFont: UOFont.caption(11),
                versionColor: UOColor.textMuted,
                userIdFont: UOFont.bodyMedium(12),
                userIdColor: UOColor.textMuted,
                copyButtonStyle: CopyButtonStyle(
                    font: UOFont.subtitle(14),
                    color: UOColor.primary,
                    backgroundColor: UOColor.primary.withAlphaComponent(0.1)
                )
            )
        )
    }
}
