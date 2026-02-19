//
//  UOPopupModels.swift
//  UOComponents
//
//  Created by Ünsal Öner on 16.02.2026.
//

import UIKit

// MARK: - Toast Layout

public enum UOPopupToastLayout {
    case minimal
    case withIcon
}

// MARK: - Toast Position

public enum UOPopupToastPosition {
    case top
    case bottom
}

// MARK: - Toast Config & Style

public struct UOPopupToastConfig {
    public let message: String
    public let iconName: String?
    public let duration: TimeInterval
    public let position: UOPopupToastPosition
    public let layout: UOPopupToastLayout

    public init(
        message: String,
        iconName: String? = nil,
        duration: TimeInterval = 2.5,
        position: UOPopupToastPosition = .top,
        layout: UOPopupToastLayout = .minimal
    ) {
        self.message = message
        self.iconName = iconName
        self.duration = duration
        self.position = position
        self.layout = layout
    }
}

public struct UOPopupToastStyle {
    public let backgroundColor: UIColor
    public let messageFont: UIFont
    public let messageColor: UIColor
    public let iconTint: UIColor
    public let cornerRadius: CGFloat
    public let padding: CGFloat

    public init(
        backgroundColor: UIColor,
        messageFont: UIFont,
        messageColor: UIColor,
        iconTint: UIColor,
        cornerRadius: CGFloat,
        padding: CGFloat
    ) {
        self.backgroundColor = backgroundColor
        self.messageFont = messageFont
        self.messageColor = messageColor
        self.iconTint = iconTint
        self.cornerRadius = cornerRadius
        self.padding = padding
    }

    public static func `default`() -> UOPopupToastStyle {
        UOPopupToastStyle(
            backgroundColor: UOColor.textPrimary,
            messageFont: UOFont.subtitle(14),
            messageColor: .white,
            iconTint: .white,
            cornerRadius: 12,
            padding: 16
        )
    }
}

// MARK: - Dialog Layout

public enum UOPopupDialogLayout {
    case minimal
    case withIcon
    case singleButton
    case twoButtons
}

// MARK: - Dialog Button Style

public struct UOPopupDialogButtonStyle {
    public let font: UIFont
    public let color: UIColor
    public let backgroundColor: UIColor

    public init(font: UIFont, color: UIColor, backgroundColor: UIColor) {
        self.font = font
        self.color = color
        self.backgroundColor = backgroundColor
    }
}

// MARK: - Dialog Config & Style

public struct UOPopupDialogConfig {
    public let title: String?
    public let message: String
    public let iconName: String?
    public let layout: UOPopupDialogLayout
    public let primaryButtonTitle: String
    public let primaryAction: () -> Void
    public let secondaryButtonTitle: String?
    public let secondaryAction: (() -> Void)?

    public init(
        title: String? = nil,
        message: String,
        iconName: String? = nil,
        layout: UOPopupDialogLayout = .singleButton,
        primaryButtonTitle: String,
        primaryAction: @escaping () -> Void,
        secondaryButtonTitle: String? = nil,
        secondaryAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.iconName = iconName
        self.layout = layout
        self.primaryButtonTitle = primaryButtonTitle
        self.primaryAction = primaryAction
        self.secondaryButtonTitle = secondaryButtonTitle
        self.secondaryAction = secondaryAction
    }
}

public struct UOPopupDialogStyle {
    public let cardBackground: UIColor
    public let cornerRadius: CGFloat
    public let titleFont: UIFont
    public let titleColor: UIColor
    public let messageFont: UIFont
    public let messageColor: UIColor
    public let iconTint: UIColor
    public let primaryButtonStyle: UOPopupDialogButtonStyle
    public let secondaryButtonStyle: UOPopupDialogButtonStyle

    public init(
        cardBackground: UIColor,
        cornerRadius: CGFloat,
        titleFont: UIFont,
        titleColor: UIColor,
        messageFont: UIFont,
        messageColor: UIColor,
        iconTint: UIColor,
        primaryButtonStyle: UOPopupDialogButtonStyle,
        secondaryButtonStyle: UOPopupDialogButtonStyle
    ) {
        self.cardBackground = cardBackground
        self.cornerRadius = cornerRadius
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.messageFont = messageFont
        self.messageColor = messageColor
        self.iconTint = iconTint
        self.primaryButtonStyle = primaryButtonStyle
        self.secondaryButtonStyle = secondaryButtonStyle
    }

    public static func `default`() -> UOPopupDialogStyle {
        UOPopupDialogStyle(
            cardBackground: UOColor.surface,
            cornerRadius: 16,
            titleFont: UOFont.title(18),
            titleColor: UOColor.textPrimary,
            messageFont: UOFont.body(15),
            messageColor: UOColor.textSecondary,
            iconTint: UOColor.primary,
            primaryButtonStyle: UOPopupDialogButtonStyle(
                font: UOFont.button(16),
                color: .white,
                backgroundColor: UOColor.primary
            ),
            secondaryButtonStyle: UOPopupDialogButtonStyle(
                font: UOFont.subtitle(16),
                color: UOColor.textSecondary,
                backgroundColor: UOColor.border
            )
        )
    }
}

// MARK: - Bottom Sheet Layout

public enum UOPopupBottomSheetLayout {
    case minimal
    case withIcon
    case withActions
}

// MARK: - Bottom Sheet Action

public struct UOPopupBottomSheetAction {
    public let title: String
    public let style: UOPopupBottomSheetActionStyle
    public let action: () -> Void

    public init(title: String, style: UOPopupBottomSheetActionStyle = .normal, action: @escaping () -> Void) {
        self.title = title
        self.style = style
        self.action = action
    }
}

public enum UOPopupBottomSheetActionStyle {
    case normal
    case destructive
}

// MARK: - Bottom Sheet Config & Style

public struct UOPopupBottomSheetConfig {
    public let title: String?
    public let message: String?
    public let iconName: String?
    public let layout: UOPopupBottomSheetLayout
    public let actions: [UOPopupBottomSheetAction]

    public init(
        title: String? = nil,
        message: String? = nil,
        iconName: String? = nil,
        layout: UOPopupBottomSheetLayout = .withActions,
        actions: [UOPopupBottomSheetAction]
    ) {
        self.title = title
        self.message = message
        self.iconName = iconName
        self.layout = layout
        self.actions = actions
    }
}

public struct UOPopupBottomSheetStyle {
    public let backgroundColor: UIColor
    public let titleFont: UIFont
    public let titleColor: UIColor
    public let messageFont: UIFont
    public let messageColor: UIColor
    public let actionCellBackground: UIColor
    public let actionCellFont: UIFont
    public let actionCellColor: UIColor
    public let destructiveColor: UIColor

    public init(
        backgroundColor: UIColor,
        titleFont: UIFont,
        titleColor: UIColor,
        messageFont: UIFont,
        messageColor: UIColor,
        actionCellBackground: UIColor,
        actionCellFont: UIFont,
        actionCellColor: UIColor,
        destructiveColor: UIColor
    ) {
        self.backgroundColor = backgroundColor
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.messageFont = messageFont
        self.messageColor = messageColor
        self.actionCellBackground = actionCellBackground
        self.actionCellFont = actionCellFont
        self.actionCellColor = actionCellColor
        self.destructiveColor = destructiveColor
    }

    public static func `default`() -> UOPopupBottomSheetStyle {
        UOPopupBottomSheetStyle(
            backgroundColor: UOColor.surface,
            titleFont: UOFont.title(18),
            titleColor: UOColor.textPrimary,
            messageFont: UOFont.body(15),
            messageColor: UOColor.textSecondary,
            actionCellBackground: UOColor.surface,
            actionCellFont: UOFont.subtitle(16),
            actionCellColor: UOColor.textPrimary,
            destructiveColor: UOColor.error
        )
    }
}

// MARK: - Popover Layout

public enum UOPopupPopoverLayout {
    case minimal
    case withList
}

// MARK: - Popover Item

public struct UOPopupPopoverItem {
    public let title: String
    public let iconName: String?

    public init(title: String, iconName: String? = nil) {
        self.title = title
        self.iconName = iconName
    }
}

// MARK: - Popover Config & Style

public struct UOPopupPopoverConfig {
    public let title: String?
    public let layout: UOPopupPopoverLayout
    public let message: String?
    public let items: [UOPopupPopoverItem]?
    public let onSelectItem: ((Int) -> Void)?

    public init(
        title: String? = nil,
        layout: UOPopupPopoverLayout = .minimal,
        message: String? = nil,
        items: [UOPopupPopoverItem]? = nil,
        onSelectItem: ((Int) -> Void)? = nil
    ) {
        self.title = title
        self.layout = layout
        self.message = message
        self.items = items
        self.onSelectItem = onSelectItem
    }
}

public struct UOPopupPopoverStyle {
    public let contentBackground: UIColor
    public let titleFont: UIFont
    public let titleColor: UIColor
    public let itemFont: UIFont
    public let itemColor: UIColor
    public let cornerRadius: CGFloat
    public let preferredWidth: CGFloat

    public init(
        contentBackground: UIColor,
        titleFont: UIFont,
        titleColor: UIColor,
        itemFont: UIFont,
        itemColor: UIColor,
        cornerRadius: CGFloat,
        preferredWidth: CGFloat
    ) {
        self.contentBackground = contentBackground
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.itemFont = itemFont
        self.itemColor = itemColor
        self.cornerRadius = cornerRadius
        self.preferredWidth = preferredWidth
    }

    public static func `default`() -> UOPopupPopoverStyle {
        UOPopupPopoverStyle(
            contentBackground: UOColor.surface,
            titleFont: UOFont.title(16),
            titleColor: UOColor.textPrimary,
            itemFont: UOFont.body(15),
            itemColor: UOColor.textPrimary,
            cornerRadius: 12,
            preferredWidth: 220
        )
    }
}
