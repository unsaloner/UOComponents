//
//  UOPopoverViewController.swift
//  UOComponents
//
//  Created by Ünsal Öner on 16.02.2026.
//

import UIKit
import SnapKit

public final class UOPopoverContentViewController: UIViewController {

    private let config: UOPopupPopoverConfig
    private let style: UOPopupPopoverStyle

    private lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = style.contentBackground
        v.layer.cornerRadius = style.cornerRadius
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
        .font(style.itemFont)
        .textColor(style.itemColor)
        .alignment(.center)
        .lines(0)
        .build()

    private lazy var itemsStackView: UIStackView = UIStackView
        .builder()
        .vertical(spacing: 0)
        .build()

    public init(config: UOPopupPopoverConfig, style: UOPopupPopoverStyle = .default()) {
        self.config = config
        self.style = style
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .popover
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        var previous: UIView?
        if let title = config.title, !title.isEmpty {
            titleLabel.text = title
            contentView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview().inset(16)
            }
            previous = titleLabel
        }

        switch config.layout {
        case .minimal:
            if let message = config.message {
                messageLabel.text = message
                contentView.addSubview(messageLabel)
                messageLabel.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview().inset(16)
                    if let p = previous {
                        make.top.equalTo(p.snp.bottom).offset(12)
                    } else {
                        make.top.equalToSuperview().offset(16)
                    }
                    make.bottom.equalToSuperview().offset(-16)
                }
                previous = messageLabel
            }
        case .withList:
            guard let items = config.items, !items.isEmpty else { break }
            contentView.addSubview(itemsStackView)
            for (index, item) in items.enumerated() {
                let cell = makeItemCell(item: item, index: index)
                itemsStackView.addArrangedSubview(cell)
            }
            itemsStackView.snp.makeConstraints { make in
                if let p = previous {
                    make.top.equalTo(p.snp.bottom).offset(12)
                } else {
                    make.top.equalToSuperview().offset(16)
                }
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview().offset(-16)
            }
            previous = itemsStackView
        }

        let estimatedHeight: CGFloat
        switch config.layout {
        case .minimal:
            estimatedHeight = (config.title != nil ? 44 : 0) + 60
        case .withList:
            let itemCount = CGFloat(config.items?.count ?? 0)
            estimatedHeight = (config.title != nil ? 44 : 0) + itemCount * 44 + 32
        }
        preferredContentSize = CGSize(width: style.preferredWidth, height: min(estimatedHeight, 400))
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = style.preferredWidth
        let height = contentView.systemLayoutSizeFitting(CGSize(width: width, height: .greatestFiniteMagnitude), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height
        if height > 0 {
            preferredContentSize = CGSize(width: width, height: min(height + 32, 400))
        }
    }

    private func makeItemCell(item: UOPopupPopoverItem, index: Int) -> UIView {
        let container = UIView()
        let label = UILabel
            .builder()
            .text(item.title)
            .font(style.itemFont)
            .textColor(style.itemColor)
            .lines(1)
            .build()
        container.addSubview(label)
        var iconView: UIImageView?
        if let iconName = item.iconName {
            let iv = UIImageView
                .builder()
                .image(systemName: iconName)
                .tintColor(style.itemColor)
                .aspectFit()
                .build()
            container.addSubview(iv)
            iconView = iv
        }
        if let iv = iconView {
            iv.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(16)
                make.centerY.equalToSuperview()
                make.size.equalTo(20)
            }
            label.snp.makeConstraints { make in
                make.leading.equalTo(iv.snp.trailing).offset(12)
                make.trailing.equalToSuperview().offset(-16)
                make.top.bottom.equalToSuperview()
                make.height.equalTo(44)
            }
        } else {
            label.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(16)
                make.top.bottom.equalToSuperview()
                make.height.equalTo(44)
            }
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(itemTapped(_:)))
        container.addGestureRecognizer(tap)
        container.isUserInteractionEnabled = true
        container.tag = index
        return container
    }

    @objc private func itemTapped(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view else { return }
        let index = view.tag
        dismiss(animated: true) {
            self.config.onSelectItem?(index)
        }
    }
}
