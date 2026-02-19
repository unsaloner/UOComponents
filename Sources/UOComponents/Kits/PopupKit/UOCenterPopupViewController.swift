//
//  UOCenterPopupViewController.swift
//  UOComponents
//
//  Created by Ünsal Öner on 16.02.2026.
//

import UIKit
import SnapKit

public final class UOCenterPopupViewController: UIViewController {

    private let config: UOPopupDialogConfig
    private let style: UOPopupDialogStyle

    private lazy var dimmingView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        v.alpha = 0
        return v
    }()

    private lazy var cardView: UIView = {
        let v = UIView()
        v.backgroundColor = style.cardBackground
        v.layer.cornerRadius = style.cornerRadius
        v.clipsToBounds = true
        return v
    }()

    private lazy var iconImageView: UIImageView = UIImageView
        .builder()
        .aspectFit()
        .tintColor(style.iconTint)
        .build()

    private lazy var titleLabel: UILabel = UILabel
        .builder()
        .font(style.titleFont)
        .textColor(style.titleColor)
        .alignment(.center)
        .lines(0)
        .build()

    private lazy var messageLabel: UILabel = UILabel
        .builder()
        .font(style.messageFont)
        .textColor(style.messageColor)
        .alignment(.center)
        .lines(0)
        .build()

    private lazy var primaryButton: UIButton = UIButton
        .builder()
        .title(config.primaryButtonTitle)
        .font(style.primaryButtonStyle.font)
        .titleColor(style.primaryButtonStyle.color)
        .configure { [style] button in
            button.backgroundColor = style.primaryButtonStyle.backgroundColor
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(primaryTapped), for: .touchUpInside)
        }
        .build()

    private lazy var secondaryButton: UIButton = UIButton
        .builder()
        .title(config.secondaryButtonTitle ?? "Cancel")
        .font(style.secondaryButtonStyle.font)
        .titleColor(style.secondaryButtonStyle.color)
        .configure { [style] button in
            button.backgroundColor = style.secondaryButtonStyle.backgroundColor
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(secondaryTapped), for: .touchUpInside)
        }
        .build()

    public init(config: UOPopupDialogConfig, style: UOPopupDialogStyle = .default()) {
        self.config = config
        self.style = style
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(dimmingView)
        view.addSubview(cardView)
        dimmingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        cardView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
        }

        messageLabel.text = config.message
        cardView.addSubview(messageLabel)

        let showTitle = config.title != nil && !(config.title?.isEmpty ?? true)
        if showTitle {
            titleLabel.text = config.title
            cardView.addSubview(titleLabel)
        }

        let showIcon = config.layout == .withIcon && config.iconName != nil
        if showIcon, let name = config.iconName {
            iconImageView.image = UIImage(systemName: name)
            cardView.addSubview(iconImageView)
        }

        let showPrimary = true
        if showPrimary {
            cardView.addSubview(primaryButton)
            primaryButton.snp.makeConstraints { make in
                make.height.equalTo(44)
            }
        }

        let showSecondary = config.layout == .twoButtons && config.secondaryButtonTitle != nil
        if showSecondary {
            cardView.addSubview(secondaryButton)
            secondaryButton.snp.makeConstraints { make in
                make.height.equalTo(44)
            }
        }

        var previous: UIView?
        if showIcon, let iv = iconImageView.image {
            iconImageView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(24)
                make.centerX.equalToSuperview()
                make.size.equalTo(44)
            }
            previous = iconImageView
        }
        if showTitle {
            titleLabel.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(20)
                if let p = previous {
                    make.top.equalTo(p.snp.bottom).offset(12)
                } else {
                    make.top.equalToSuperview().offset(24)
                }
            }
            previous = titleLabel
        }
        messageLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            if let p = previous {
                make.top.equalTo(p.snp.bottom).offset(12)
            } else {
                make.top.equalToSuperview().offset(24)
            }
        }
        previous = messageLabel

        if showPrimary {
            primaryButton.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(20)
                make.top.equalTo(previous!.snp.bottom).offset(20)
            }
            previous = primaryButton
        }
        if showSecondary {
            secondaryButton.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(20)
                make.top.equalTo(previous!.snp.bottom).offset(8)
            }
            previous = secondaryButton
        }

        cardView.snp.makeConstraints { make in
            make.bottom.equalTo(previous!.snp.bottom).offset(24)
        }
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.25) {
            self.dimmingView.alpha = 1
        }
    }

    @objc private func primaryTapped() {
        config.primaryAction()
        dismiss(animated: true)
    }

    @objc private func secondaryTapped() {
        config.secondaryAction?()
        dismiss(animated: true)
    }
}
