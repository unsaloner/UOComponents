//
//  UOBottomSheetViewController.swift
//  UOComponents
//
//  Created by Ünsal Öner on 16.02.2026.
//

import UIKit
import SnapKit

public final class UOBottomSheetViewController: UIViewController {

    private let config: UOPopupBottomSheetConfig
    private let style: UOPopupBottomSheetStyle

    private lazy var sheetView: UIView = {
        let v = UIView()
        v.backgroundColor = style.backgroundColor
        v.layer.cornerRadius = 20
        v.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        v.clipsToBounds = true
        return v
    }()

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

    private lazy var iconImageView: UIImageView = UIImageView
        .builder()
        .aspectFit()
        .tintColor(style.titleColor)
        .build()

    private lazy var actionsStackView: UIStackView = UIStackView
        .builder()
        .vertical(spacing: 0)
        .build()

    public init(config: UOPopupBottomSheetConfig, style: UOPopupBottomSheetStyle = .default()) {
        self.config = config
        self.style = style
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .pageSheet
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(sheetView)
        sheetView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        var previous: UIView?
        let showIcon = (config.layout == .withIcon || config.layout == .withActions) && config.iconName != nil
        if showIcon, let name = config.iconName {
            iconImageView.image = UIImage(systemName: name)
            sheetView.addSubview(iconImageView)
            iconImageView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(24)
                make.centerX.equalToSuperview()
                make.size.equalTo(40)
            }
            previous = iconImageView
        }

        let showTitle = config.title != nil && !(config.title?.isEmpty ?? true)
        if showTitle {
            titleLabel.text = config.title
            sheetView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(24)
                if let p = previous {
                    make.top.equalTo(p.snp.bottom).offset(12)
                } else {
                    make.top.equalToSuperview().offset(24)
                }
            }
            previous = titleLabel
        }

        let showMessage = config.message != nil && !(config.message?.isEmpty ?? true)
        if showMessage {
            messageLabel.text = config.message
            sheetView.addSubview(messageLabel)
            messageLabel.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(24)
                if let p = previous {
                    make.top.equalTo(p.snp.bottom).offset(8)
                } else {
                    make.top.equalToSuperview().offset(24)
                }
            }
            previous = messageLabel
        }

        if !config.actions.isEmpty {
            sheetView.addSubview(actionsStackView)
            for (index, action) in config.actions.enumerated() {
                let cell = makeActionCell(action: action, index: index)
                actionsStackView.addArrangedSubview(cell)
            }
            actionsStackView.snp.makeConstraints { make in
                if let p = previous {
                    make.top.equalTo(p.snp.bottom).offset(20)
                } else {
                    make.top.equalToSuperview().offset(24)
                }
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-24)
            }
        } else if let p = previous {
            sheetView.snp.makeConstraints { make in
                make.bottom.equalTo(p.snp.bottom).offset(24)
            }
        }
    }

    private func makeActionCell(action: UOPopupBottomSheetAction, index: Int) -> UIView {
        let container = UIView()
        container.backgroundColor = style.actionCellBackground
        let label = UILabel
            .builder()
            .text(action.title)
            .font(style.actionCellFont)
            .textColor(action.style == .destructive ? style.destructiveColor : style.actionCellColor)
            .alignment(.center)
            .build()
        container.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(52)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(actionTapped(_:)))
        container.addGestureRecognizer(tap)
        container.isUserInteractionEnabled = true
        container.tag = index
        return container
    }

    @objc private func actionTapped(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view, view.tag < config.actions.count else { return }
        let action = config.actions[view.tag]
        dismiss(animated: true) {
            action.action()
        }
    }
}
