//
//  UOSettingsViewController.swift
//  UOComponents
//
//  Created by Ünsal Öner on 16.02.2026.
//

import UIKit
import SnapKit

public final class UOSettingsViewController: UIViewController {

    public weak var delegate: UOSettingsDelegate?

    private let config: UOSettingsConfig
    private let style: UOSettingsStyle

    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        return sv
    }()

    private lazy var contentView = UIView()

    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = style.header.backgroundColor
        return view
    }()

    private lazy var backButton: UIButton = UIButton
        .builder()
        .configure { [style] button in
            let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
            button.setImage(UIImage(systemName: "chevron.left", withConfiguration: config), for: .normal)
            button.tintColor = style.header.backButtonTint
            button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        }
        .build()

    private lazy var titleLabel: UILabel = UILabel
        .builder()
        .text(config.headerTitle)
        .font(style.header.titleFont)
        .textColor(style.header.titleColor)
        .alignment(.center)
        .build()

    private lazy var mainStackView: UIStackView = UIStackView
        .builder()
        .vertical(spacing: 24)
        .build()

    private lazy var footerView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var userIdTitleLabel: UILabel = UILabel
        .builder()
        .text("User ID")
        .font(style.footer.userIdFont)
        .textColor(style.footer.userIdColor)
        .alignment(.center)
        .build()

    private lazy var userIdLabel: UILabel = UILabel
        .builder()
        .font(style.footer.userIdFont)
        .textColor(style.footer.userIdColor)
        .alignment(.center)
        .lines(1)
        .build()

    private lazy var copyDeviceIdButton: UIButton = UIButton
        .builder()
        .title("Copy ID")
        .titleColor(style.footer.copyButtonStyle.color)
        .font(style.footer.copyButtonStyle.font)
        .configure { [style] button in
            button.backgroundColor = style.footer.copyButtonStyle.backgroundColor
            button.layer.cornerRadius = 8
            button.addTarget(self, action: #selector(copyDeviceIdTapped), for: .touchUpInside)
        }
        .build()

    private lazy var versionLabel: UILabel = UILabel
        .builder()
        .font(style.footer.versionFont)
        .textColor(style.footer.versionColor)
        .alignment(.center)
        .build()

    public init(config: UOSettingsConfig, style: UOSettingsStyle = .default()) {
        self.config = config
        self.style = style
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupUI()
        setupConstraints()
        setupFooter()
    }

    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = style.header.backgroundColor

        view.addSubview(headerView)
        headerView.addSubview(backButton)
        headerView.addSubview(titleLabel)

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainStackView)

        for section in config.sections {
            let sectionView = createSection(title: section.title)
            let stack = sectionView.viewWithTag(100) as? UIStackView
            for item in section.items {
                stack?.addArrangedSubview(createSettingsItem(item: item))
            }
            mainStackView.addArrangedSubview(sectionView)
        }

        contentView.addSubview(footerView)
        footerView.addSubview(userIdTitleLabel)
        footerView.addSubview(userIdLabel)
        footerView.addSubview(copyDeviceIdButton)
        footerView.addSubview(versionLabel)
    }

    private func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(56)
        }

        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(44)
        }

        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }

        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        footerView.snp.makeConstraints { make in
            make.top.equalTo(mainStackView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-40)
        }

        userIdTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        userIdLabel.snp.makeConstraints { make in
            make.top.equalTo(userIdTitleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
        }

        copyDeviceIdButton.snp.makeConstraints { make in
            make.top.equalTo(userIdLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(36)
        }

        versionLabel.snp.makeConstraints { make in
            make.top.equalTo(copyDeviceIdButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func setupFooter() {
        guard let footer = config.footer else {
            footerView.isHidden = true
            return
        }
        versionLabel.text = footer.versionText
        userIdLabel.text = footer.userIdText
        userIdTitleLabel.isHidden = footer.userIdText == nil
        userIdLabel.isHidden = footer.userIdText == nil
        copyDeviceIdButton.isHidden = !footer.showCopyButton
        copyDeviceIdButton.snp.remakeConstraints { make in
            make.top.equalTo(userIdLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(footer.showCopyButton ? 36 : 0)
        }
    }

    // MARK: - Section Builders

    private func createSection(title: String) -> UIView {
        let container = UIView()

        let titleLabel = UILabel
            .builder()
            .text(title)
            .font(style.section.titleFont)
            .textColor(style.section.titleColor)
            .build()

        let stack = UIStackView
            .builder()
            .vertical(spacing: 8)
            .configure { $0.tag = 100 }
            .build()

        container.addSubview(titleLabel)
        container.addSubview(stack)

        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }

        stack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }

        return container
    }

    private func createSettingsItem(item: UOSettingsItem) -> UIView {
        let container = UIView()
        container.backgroundColor = style.item.backgroundColor
        container.layer.cornerRadius = 12

        let iconContainer = UIView()
        let iconTint = item.isDestructive ? style.item.destructiveColor : style.item.iconTint
        iconContainer.backgroundColor = iconTint.withAlphaComponent(0.1)
        iconContainer.layer.cornerRadius = 8

        let iconImageView = UIImageView
            .builder()
            .image(systemName: item.iconName)
            .tintColor(iconTint)
            .configure { iv in
                let symbolConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .medium)
                iv.image = UIImage(systemName: item.iconName, withConfiguration: symbolConfig)
            }
            .build()

        let titleLabel = UILabel
            .builder()
            .text(item.title)
            .font(style.item.titleFont)
            .textColor(item.isDestructive ? style.item.destructiveColor : style.item.titleColor)
            .build()

        let arrowImageView = UIImageView
            .builder()
            .image(systemName: "chevron.right")
            .tintColor(UOColor.textMuted)
            .configure { iv in
                let symbolConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .semibold)
                iv.image = UIImage(systemName: "chevron.right", withConfiguration: symbolConfig)
            }
            .build()

        container.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        container.addSubview(titleLabel)
        container.addSubview(arrowImageView)

        iconContainer.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(32)
        }

        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconContainer.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
        }

        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }

        container.snp.makeConstraints { make in
            make.height.equalTo(56)
        }

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleItemTap(_:)))
        container.addGestureRecognizer(tap)
        container.isUserInteractionEnabled = true
        container.tag = item.type.rawValue

        return container
    }

    // MARK: - Actions

    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func handleItemTap(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view,
              let type = UOSettingsItemType(rawValue: view.tag) else { return }

        switch type {
        case .rateApp:
            delegate?.settingsDidTapRateApp(self)
        case .shareApp:
            delegate?.settingsDidTapShareApp(self)
        case .contactSupport:
            delegate?.settingsDidTapSupport(self)
        case .termsOfService:
            openWeb(urlString: config.termsURL, title: config.termsTitle ?? "Terms")
        case .privacyPolicy:
            openWeb(urlString: config.privacyURL, title: config.privacyTitle ?? "Privacy")
        case .restorePurchases:
            delegate?.settingsDidTapRestorePurchases(self)
        case .deleteAccount:
            delegate?.settingsDidTapDeleteAccount(self)
        case .copyUserId:
            delegate?.settingsDidTapCopyUserId(self)
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            UIView.animate(withDuration: 0.15) {
                self.copyDeviceIdButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            } completion: { _ in
                UIView.animate(withDuration: 0.15) {
                    self.copyDeviceIdButton.transform = .identity
                }
            }
        }
    }

    @objc private func copyDeviceIdTapped() {
        delegate?.settingsDidTapCopyUserId(self)
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        UIView.animate(withDuration: 0.15) {
            self.copyDeviceIdButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            UIView.animate(withDuration: 0.15) {
                self.copyDeviceIdButton.transform = .identity
            }
        }
    }

    private func openWeb(urlString: String?, title: String) {
        guard let urlString = urlString, !urlString.isEmpty, let url = URL(string: urlString) else { return }
        let webVC = UOWebViewController(url: url, title: title)
        let navVC = UINavigationController(rootViewController: webVC)
        navVC.modalPresentationStyle = .pageSheet
        present(navVC, animated: true)
    }
}
