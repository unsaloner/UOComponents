//
//  UOOnboardingCell.swift
//  UOComponents
//
//  Created by Ünsal Öner on 14.02.2026.
//

import UIKit
import AVFoundation
import SnapKit

final class UOOnboardingCell: UICollectionViewCell {

    static let identifier = "UOOnboardingCell"

    private var playerLayer: AVPlayerLayer?
    private var mediaType: UOOnboardingMediaType = .image

    private let mediaContainerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()

    private let mediaImageView = UIImageView
        .builder()
        .aspectFill()
        .build()

    private let titleLabel = UILabel
        .builder()
        .alignment(.center)
        .lines(2)
        .build()

    private let descriptionLabel = UILabel
        .builder()
        .alignment(.center)
        .lines(3)
        .build()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupUI() {
        contentView.addSubview(mediaContainerView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)

        mediaContainerView.addSubview(mediaImageView)

        mediaContainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(mediaContainerView.snp.width).dividedBy(0.85)
        }

        mediaImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mediaContainerView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(32)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = mediaContainerView.bounds
    }

    // MARK: - Configure (Video)

    public func configure(page: UOOnboardingPage, player: AVQueuePlayer, style: UOOnboardingStyle) {
        mediaType = .video
        mediaImageView.isHidden = true
        applyStyle(style)
        applyTitle(page: page, style: style)
        applyDescription(page: page, style: style)

        mediaContainerView.backgroundColor = style.media.containerColor
        mediaContainerView.layer.cornerRadius = style.media.cornerRadius

        playerLayer?.removeFromSuperlayer()

        let layer = AVPlayerLayer(player: player)
        layer.videoGravity = .resizeAspectFill
        mediaContainerView.layer.addSublayer(layer)
        playerLayer = layer

        if player.rate == 0 {
            player.play()
        }

        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.playerLayer?.frame = self.mediaContainerView.bounds
        }
    }

    // MARK: - Configure (Image)

    public func configure(page: UOOnboardingPage, style: UOOnboardingStyle) {
        mediaType = .image
        mediaImageView.isHidden = false
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil

        applyStyle(style)
        applyTitle(page: page, style: style)
        applyDescription(page: page, style: style)

        mediaContainerView.backgroundColor = style.media.containerColor
        mediaContainerView.layer.cornerRadius = style.media.cornerRadius

        mediaImageView.image = UIImage(named: page.mediaName) ?? UIImage(systemName: page.mediaName)
    }

    // MARK: - Styling Helpers

    private func applyStyle(_ style: UOOnboardingStyle) {
        titleLabel.font = style.typography.titleFont
        titleLabel.textColor = style.colors.title
        descriptionLabel.font = style.typography.descriptionFont
        descriptionLabel.textColor = style.colors.description
    }

    private func applyTitle(page: UOOnboardingPage, style: UOOnboardingStyle) {
        guard let highlightWord = page.highlightWord,
              let range = page.title.range(of: highlightWord) else {
            titleLabel.text = page.title
            return
        }

        let color = page.highlightColor ?? style.colors.defaultHighlight

        let attributed = NSMutableAttributedString(
            string: page.title,
            attributes: [
                .font: style.typography.highlightFont,
                .foregroundColor: style.colors.title
            ]
        )

        attributed.addAttribute(
            .foregroundColor,
            value: color,
            range: NSRange(range, in: page.title)
        )

        titleLabel.attributedText = attributed
    }

    private func applyDescription(page: UOOnboardingPage, style: UOOnboardingStyle) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = style.typography.descriptionLineSpacing
        paragraphStyle.alignment = .center

        descriptionLabel.attributedText = NSAttributedString(
            string: page.description,
            attributes: [
                .font: style.typography.descriptionFont,
                .foregroundColor: style.colors.description,
                .paragraphStyle: paragraphStyle
            ]
        )
    }

    // MARK: - Reuse

    override func prepareForReuse() {
        super.prepareForReuse()
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
        mediaImageView.image = nil
        titleLabel.text = nil
        titleLabel.attributedText = nil
        descriptionLabel.text = nil
        descriptionLabel.attributedText = nil
    }
}
