//
//  UOToastView.swift
//  UOComponents
//
//  Created by Ünsal Öner on 16.02.2026.
//

import UIKit
import SnapKit

public enum UOPopupToast {

    public static func show(config: UOPopupToastConfig, style: UOPopupToastStyle = .default(), in view: UIView? = nil) {
        let targetView = view ?? UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow } ?? UIView()

        let container = UIView()
        container.backgroundColor = style.backgroundColor
        container.layer.cornerRadius = style.cornerRadius
        container.alpha = 0
        targetView.addSubview(container)

        let messageLabel = UILabel
            .builder()
            .text(config.message)
            .font(style.messageFont)
            .textColor(style.messageColor)
            .lines(0)
            .alignment(.center)
            .build()
        container.addSubview(messageLabel)

        var iconImageView: UIImageView?
        if config.layout == .withIcon, let iconName = config.iconName {
            let iv = UIImageView
                .builder()
                .image(systemName: iconName)
                .tintColor(style.iconTint)
                .aspectFit()
                .build()
            container.addSubview(iv)
            iconImageView = iv
        }

        let isTop = config.position == .top
        container.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            if isTop {
                make.top.equalTo(targetView.safeAreaLayoutGuide).offset(16)
            } else {
                make.bottom.equalTo(targetView.safeAreaLayoutGuide).offset(-16)
            }
        }
        container.transform = CGAffineTransform(translationX: 0, y: isTop ? -80 : 80)

        if let iv = iconImageView {
            iv.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(style.padding)
                make.centerX.equalToSuperview()
                make.size.equalTo(28)
            }
            messageLabel.snp.makeConstraints { make in
                make.top.equalTo(iv.snp.bottom).offset(8)
                make.leading.trailing.equalToSuperview().inset(style.padding)
                make.bottom.equalToSuperview().offset(-style.padding)
            }
        } else {
            messageLabel.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(style.padding)
            }
        }

        targetView.layoutIfNeeded()

        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseOut) {
            container.alpha = 1
            container.transform = .identity
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: config.duration, options: .curveEaseIn) {
                container.alpha = 0
                container.transform = CGAffineTransform(translationX: 0, y: isTop ? -80 : 80)
            } completion: { _ in
                container.removeFromSuperview()
            }
        }
    }
}
