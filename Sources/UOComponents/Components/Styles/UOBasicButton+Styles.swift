//
//  UOBasicButton+Styles.swift
//  UOComponents
//
//  Created by Ünsal Öner on 12.02.2026.
//

import UIKit

public extension UOBasicButtonBuilder {
    
    @discardableResult
    public func primaryStyle() -> Self {
        return self
            .backgroundColor(UOColor.primary)
            .titleColor(.white)
            .font(UOFont.button())
            .cornerRadius(12)
            .haptic()
            .jumpAnimation()
            .contentInsets(UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16))
    }
    
    @discardableResult
    public func secondaryStyle() -> Self {
        return self
            .backgroundColor(UOColor.surface)
            .titleColor(UOColor.primary)
            .font(UOFont.button())
            .cornerRadius(12)
            .border(width: 1.5, color: UOColor.primary)
            .contentInsets(UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16))
    }
  
    @discardableResult
    public func continueStyle() -> Self {
        return self
            .backgroundColor(UOColor.primary)
            .title("CONTINUE")
            .titleColor(.white)
            .font(UOFont.button())
            .cornerRadius(12)
            .haptic()
            .jumpAnimation()
            .contentInsets(UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16))
    }

    @discardableResult
    public func destructiveStyle() -> Self {
        return self
            .backgroundColor(UOColor.error)
            .titleColor(.white)
            .font(UOFont.button())
            .cornerRadius(12)
            .haptic(.heavy)
            .jumpAnimation()
            .contentInsets(UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16))
    }

    @discardableResult
    public func textOnlyStyle() -> Self {
        return self
            .backgroundColor(.clear)
            .titleColor(UOColor.primary)
            .font(UOFont.button())
            .contentInsets(UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12))
    }

    @discardableResult
    public func disabledStyle() -> Self {
        return self
            .backgroundColor(UOColor.border)
            .titleColor(UOColor.textMuted)
            .font(UOFont.button())
            .cornerRadius(12)
            .enabled(false)
            .contentInsets(UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16))
    }
}
