//
//  UOTextViewBuilder.swift
//  UOComponents
//
//  Created by Ünsal Öner on 14.02.2026.
//

import UIKit

public final class UOTextViewBuilder: UOBaseComponentBuilder<UITextView> {

    public init() {
        super.init(view: UITextView())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
}

public extension UOTextViewBuilder {

    @discardableResult
    public func text(_ text: String?) -> Self {
        view.text = text
        return self
    }

    @discardableResult
    public func attributedText(_ text: NSAttributedString?) -> Self {
        view.attributedText = text
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
    public func editable(_ editable: Bool) -> Self {
        view.isEditable = editable
        return self
    }

    @discardableResult
    public func selectable(_ selectable: Bool) -> Self {
        view.isSelectable = selectable
        return self
    }

    @discardableResult
    public func scrollEnabled(_ enabled: Bool) -> Self {
        view.isScrollEnabled = enabled
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
    public func textContainerInset(_ insets: UIEdgeInsets) -> Self {
        view.textContainerInset = insets
        return self
    }

    @discardableResult
    public func dataDetectorTypes(_ types: UIDataDetectorTypes) -> Self {
        view.dataDetectorTypes = types
        return self
    }
}
