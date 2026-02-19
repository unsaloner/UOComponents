//
//  UOOnboardingModels.swift
//  UOComponents
//
//  Created by Ünsal Öner on 14.02.2026.
//

import UIKit

// MARK: - Media Type

public enum UOOnboardingMediaType {
    case video
    case image
}

// MARK: - Page

public struct UOOnboardingPage {
    public let title: String
    public let description: String
    public let mediaName: String
    public let highlightWord: String?
    public let highlightColor: UIColor?

    public init(
        title: String,
        description: String,
        mediaName: String,
        highlightWord: String? = nil,
        highlightColor: UIColor? = nil
    ) {
        self.title = title
        self.description = description
        self.mediaName = mediaName
        self.highlightWord = highlightWord
        self.highlightColor = highlightColor
    }
}

// MARK: - Style

public struct UOOnboardingStyle {

    public struct Typography {
        public let titleFont: UIFont
        public let descriptionFont: UIFont
        public let highlightFont: UIFont
        public let descriptionLineSpacing: CGFloat

        public init(
            titleFont: UIFont,
            descriptionFont: UIFont,
            highlightFont: UIFont,
            descriptionLineSpacing: CGFloat
        ) {
            self.titleFont = titleFont
            self.descriptionFont = descriptionFont
            self.highlightFont = highlightFont
            self.descriptionLineSpacing = descriptionLineSpacing
        }
    }

    public struct Colors {
        public let background: UIColor
        public let backgroundImage: UIImage?
        public let title: UIColor
        public let description: UIColor
        public let defaultHighlight: UIColor

        public init(
            background: UIColor,
            backgroundImage: UIImage?,
            title: UIColor,
            description: UIColor,
            defaultHighlight: UIColor
        ) {
            self.background = background
            self.backgroundImage = backgroundImage
            self.title = title
            self.description = description
            self.defaultHighlight = defaultHighlight
        }
    }

    public struct ButtonStyle {
        public let font: UIFont
        public let color: UIColor
        public let titleColor: UIColor
        public let cornerRadius: CGFloat
        public let height: CGFloat

        public init(
            font: UIFont,
            color: UIColor,
            titleColor: UIColor,
            cornerRadius: CGFloat,
            height: CGFloat
        ) {
            self.font = font
            self.color = color
            self.titleColor = titleColor
            self.cornerRadius = cornerRadius
            self.height = height
        }
    }

    public struct PageControlStyle {
        public let activeColor: UIColor
        public let inactiveColor: UIColor
        public let dotSize: CGFloat
        public let activeDotWidth: CGFloat

        public init(
            activeColor: UIColor,
            inactiveColor: UIColor,
            dotSize: CGFloat,
            activeDotWidth: CGFloat
        ) {
            self.activeColor = activeColor
            self.inactiveColor = inactiveColor
            self.dotSize = dotSize
            self.activeDotWidth = activeDotWidth
        }
    }

    public struct MediaStyle {
        public let cornerRadius: CGFloat
        public let containerColor: UIColor

        public init(cornerRadius: CGFloat, containerColor: UIColor) {
            self.cornerRadius = cornerRadius
            self.containerColor = containerColor
        }
    }

    public let typography: Typography
    public let colors: Colors
    public let button: ButtonStyle
    public let pageControl: PageControlStyle
    public let media: MediaStyle

    public init(
        typography: Typography,
        colors: Colors,
        button: ButtonStyle,
        pageControl: PageControlStyle,
        media: MediaStyle
    ) {
        self.typography = typography
        self.colors = colors
        self.button = button
        self.pageControl = pageControl
        self.media = media
    }

    public static func `default`() -> UOOnboardingStyle {
        UOOnboardingStyle(
            typography: Typography(
                titleFont: UOFont.largeTitle(28),
                descriptionFont: UOFont.body(),
                highlightFont: UOFont.largeTitle(28),
                descriptionLineSpacing: 6
            ),
            colors: Colors(
                background: UOColor.background,
                backgroundImage: nil,
                title: UOColor.textPrimary,
                description: UOColor.textSecondary,
                defaultHighlight: UOColor.primary
            ),
            button: ButtonStyle(
                font: UOFont.button(18),
                color: UOColor.primary,
                titleColor: .white,
                cornerRadius: 30,
                height: 60
            ),
            pageControl: PageControlStyle(
                activeColor: UOColor.primary,
                inactiveColor: UOColor.border,
                dotSize: 8,
                activeDotWidth: 32
            ),
            media: MediaStyle(
                cornerRadius: 16,
                containerColor: UOColor.surface
            )
        )
    }
}

// MARK: - Config

public struct UOOnboardingConfig {
    public let pages: [UOOnboardingPage]
    public let mediaType: UOOnboardingMediaType
    public let style: UOOnboardingStyle
    public let continueTitle: String
    public let lastPageTitle: String
    public let termsText: String?
    public let termsURL: String?
    public let privacyURL: String?
    public let termsHighlightWords: [String]?

    public init(
        pages: [UOOnboardingPage],
        mediaType: UOOnboardingMediaType,
        style: UOOnboardingStyle = .default(),
        continueTitle: String = "Continue",
        lastPageTitle: String = "Get Started",
        termsText: String? = nil,
        termsURL: String? = nil,
        privacyURL: String? = nil,
        termsHighlightWords: [String]? = nil
    ) {
        self.pages = pages
        self.mediaType = mediaType
        self.style = style
        self.continueTitle = continueTitle
        self.lastPageTitle = lastPageTitle
        self.termsText = termsText
        self.termsURL = termsURL
        self.privacyURL = privacyURL
        self.termsHighlightWords = termsHighlightWords
    }
}
