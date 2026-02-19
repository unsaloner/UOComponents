//
//  UOBasicButtonBuilder.swift
//  UOComponents
//
//  Created by Ünsal Öner on 12.02.2026.
//

import UIKit

public final class UOBasicButtonBuilder: UOBaseComponentBuilder<UIButton> {

    public init(type: UIButton.ButtonType = .system) {
        super.init(view: UIButton(type: type))
    }
    
    private var interactionHandler: UOButtonInteractionHandler {
        if let handler = objc_getAssociatedObject(view, &AssociatedKeys.interactionHandler) as? UOButtonInteractionHandler {
            return handler
        }
        let handler = UOButtonInteractionHandler(button: view)
        objc_setAssociatedObject(view, &AssociatedKeys.interactionHandler, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return handler
    }
}

public extension UOBasicButtonBuilder {

    @discardableResult
    public func title(_ title: String?, for state: UIControl.State = .normal) -> Self {
        view.setTitle(title, for: state)
        return self
    }

    @discardableResult
    public func titleColor(_ color: UIColor, for state: UIControl.State = .normal) -> Self {
        view.setTitleColor(color, for: state)
        return self
    }

    @discardableResult
    public func font(_ font: UIFont) -> Self {
        view.titleLabel?.font = font
        return self
    }

    @discardableResult
    public func image(_ image: UIImage?, for state: UIControl.State = .normal) -> Self {
        view.setImage(image, for: state)
        return self
    }

    @discardableResult
    public func contentInsets(_ insets: UIEdgeInsets) -> Self {
        view.contentEdgeInsets = insets
        return self
    }

    @discardableResult
    public func enabled(_ isEnabled: Bool) -> Self {
        view.isEnabled = isEnabled
        return self
    }

    @discardableResult
    public func onTap(target: Any?, action: Selector) -> Self {
        view.addTarget(target, action: action, for: .touchUpInside)
        return self
    }

    @discardableResult
    public func onTap(_ action: @escaping () -> Void) -> Self {
        interactionHandler.tapAction = action
        return self
    }
}

public extension UOBasicButtonBuilder {
    
    @discardableResult
    public func haptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) -> Self {
        interactionHandler.hapticStyle = style
        return self
    }
    
    @discardableResult
    public func jumpAnimation(scale: CGFloat = 0.92, duration: TimeInterval = 0.12) -> Self {
        interactionHandler.animationScale = scale
        interactionHandler.animationDuration = duration
        return self
    }
}
