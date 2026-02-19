//
//  UOButtonInteractionHandler.swift
//  UOComponents
//
//  Created by Ünsal Öner on 12.02.2026.
//

import UIKit

final class UOButtonInteractionHandler: NSObject {
    
    var hapticStyle: UIImpactFeedbackGenerator.FeedbackStyle?
    var animationScale: CGFloat?
    var animationDuration: TimeInterval = 0.12
    var tapAction: (() -> Void)?
    
    init(button: UIButton) {
        super.init()
        button.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(touchUp(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        button.addTarget(self, action: #selector(touchUpInsideAction), for: .touchUpInside)
    }
    
    @objc private func touchDown(_ sender: UIButton) {
        guard let scale = animationScale else { return }
        
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            options: [.curveEaseInOut, .allowUserInteraction]
        ) {
            sender.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    @objc private func touchUp(_ sender: UIButton) {

        if let style = hapticStyle {
            UIImpactFeedbackGenerator(style: style).impactOccurred()
        }
        
        guard animationScale != nil else { return }
        
        UIView.animate(
            withDuration: animationDuration * 2.5,
            delay: 0,
            usingSpringWithDamping: 0.45,
            initialSpringVelocity: 4,
            options: .allowUserInteraction
        ) {
            sender.transform = .identity
        }
    }

    @objc private func touchUpInsideAction() {
        tapAction?()
    }
}

