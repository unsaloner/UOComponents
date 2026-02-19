//
//  UOOnboardingViewController.swift
//  UOComponents
//
//  Created by Ünsal Öner on 14.02.2026.
//

import UIKit
import AVFoundation
import SnapKit

public protocol UOOnboardingDelegate: AnyObject {
    func onboardingDidComplete(_ controller: UOOnboardingViewController)
}

public final class UOOnboardingViewController: UIViewController {

    public weak var delegate: UOOnboardingDelegate?

    private let config: UOOnboardingConfig
    private var currentPage = 0
    private var videoManager: UOOnboardingVideoManager?

    private lazy var backgroundImageView: UIImageView = UIImageView
        .builder()
        .aspectFill()
        .build()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(UOOnboardingCell.self, forCellWithReuseIdentifier: UOOnboardingCell.identifier)
        return cv
    }()

    private lazy var pageControl: UOPageControl = {
        let style = config.style.pageControl
        return UOPageControl
            .builder(totalPages: config.pages.count)
            .activeColor(style.activeColor)
            .inactiveColor(style.inactiveColor)
            .dotSize(style.dotSize)
            .activeDotWidth(style.activeDotWidth)
            .build()
    }()

    private lazy var continueButton: UIButton = UIButton
        .builder()
        .primaryStyle()
        .title(config.continueTitle)
        .configure { [config] button in
            let buttonStyle = config.style.button
            button.backgroundColor = buttonStyle.color
            button.setTitleColor(buttonStyle.titleColor, for: .normal)
            button.titleLabel?.font = buttonStyle.font
            button.layer.cornerRadius = buttonStyle.cornerRadius
            button.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        }
        .build()

    private lazy var termsLabel: UILabel? = {
        guard let termsText = config.termsText else { return nil }

        let label = UILabel
            .builder()
            .alignment(.center)
            .lines(2)
            .build()
        label.isUserInteractionEnabled = true

        let attributed = NSMutableAttributedString(
            string: termsText,
            attributes: [
                .font: UOFont.caption(12),
                .foregroundColor: UOColor.textMuted
            ]
        )
        if let highlightWords = config.termsHighlightWords {
            for word in highlightWords {
                if let range = termsText.range(of: word) {
                    attributed.addAttributes([
                        .foregroundColor: config.style.colors.title,
                        .underlineStyle: NSUnderlineStyle.single.rawValue
                    ], range: NSRange(range, in: termsText))
                }
            }
        }
        label.attributedText = attributed

        let tap = UITapGestureRecognizer(target: self, action: #selector(termsLabelTapped(_:)))
        label.addGestureRecognizer(tap)

        return label
    }()

    public init(config: UOOnboardingConfig) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        if config.mediaType == .video {
            videoManager = UOOnboardingVideoManager(pages: config.pages)
        }

        setupUI()
    }

    deinit {
        videoManager?.cleanup()
    }

    // MARK: - UI Setup

    private func setupUI() {
        let style = config.style
        view.backgroundColor = style.colors.background

        // Background image
        if let bgImage = style.colors.backgroundImage {
            backgroundImageView.image = bgImage
            view.addSubview(backgroundImageView)
            backgroundImageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }

        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(continueButton)

        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(style.button.height)
        }

        // Terms label (opsiyonel)
        if let termsLabel {
            view.addSubview(termsLabel)

            termsLabel.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(24)
                make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            }

            continueButton.snp.makeConstraints { make in
                make.bottom.equalTo(termsLabel.snp.top).offset(-16)
            }
        } else {
            continueButton.snp.makeConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-24)
            }
        }

        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(continueButton.snp.top).offset(-24)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(pageControl.snp.top).offset(-20)
        }
    }

    // MARK: - Actions

    @objc private func continueTapped() {
        if currentPage < config.pages.count - 1 {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            updatePageControl()
            updateButtonTitle()
        } else {
            videoManager?.cleanup()
            delegate?.onboardingDidComplete(self)
        }
    }

    @objc private func termsLabelTapped(_ gesture: UITapGestureRecognizer) {
        guard let label = termsLabel,
              let text = label.text,
              let highlightWords = config.termsHighlightWords else { return }

        let tapLocation = gesture.location(in: label)

        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: label.bounds.size)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines

        let index = layoutManager.characterIndex(
            for: tapLocation,
            in: textContainer,
            fractionOfDistanceBetweenInsertionPoints: nil
        )

        for (i, word) in highlightWords.enumerated() {
            let range = (text as NSString).range(of: word)
            if NSLocationInRange(index, range) {
                let urlString: String?
                if i == 0 {
                    urlString = config.termsURL
                } else {
                    urlString = config.privacyURL
                }

                if let urlString, let url = URL(string: urlString) {
                    UIApplication.shared.open(url)
                }
                return
            }
        }
    }

    private func updatePageControl() {
        pageControl.update(currentPage: currentPage)
    }

    private func updateButtonTitle() {
        let title = currentPage == config.pages.count - 1 ? config.lastPageTitle : config.continueTitle
        continueButton.setTitle(title, for: .normal)
    }
}

// MARK: - UICollectionViewDataSource

extension UOOnboardingViewController: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        config.pages.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: UOOnboardingCell.identifier,
            for: indexPath
        ) as? UOOnboardingCell else {
            return UICollectionViewCell()
        }

        let page = config.pages[indexPath.item]
        let style = config.style

        switch config.mediaType {
        case .video:
            if let player = videoManager?.player(at: indexPath.item) {
                cell.configure(page: page, player: player, style: style)
            } else {
                cell.configure(page: page, style: style)
            }
        case .image:
            cell.configure(page: page, style: style)
        }

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension UOOnboardingViewController: UICollectionViewDelegateFlowLayout {

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        collectionView.bounds.size
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        currentPage = page
        updatePageControl()
        updateButtonTitle()
    }

    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        currentPage = page
        updatePageControl()
    }
}
