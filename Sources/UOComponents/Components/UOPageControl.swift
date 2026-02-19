//
//  UOPageControl.swift
//  UOComponents
//
//  Created by Ünsal Öner on 16.02.2026.
//

import UIKit
import SnapKit

public final class UOPageControl: UIView {

    public var activeColor: UIColor = UOColor.primary {
        didSet { updateDotsAppearance() }
    }

    public var inactiveColor: UIColor = UOColor.border {
        didSet { updateDotsAppearance() }
    }

    public var dotSize: CGFloat = 8 {
        didSet { updateDotsAppearance() }
    }

    public var activeDotWidth: CGFloat = 32 {
        didSet { updateDotsAppearance() }
    }

    public var spacing: CGFloat = 8 {
        didSet {
            stackView.spacing = spacing
        }
    }

    private(set) var currentPage: Int = 0

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        return stack
    }()

    private var dotViews: [UIView] = []

    public init(totalPages: Int) {
        super.init(frame: .zero)
        assert(totalPages > 0, "totalPages must be positive")
        setupDots(totalPages: totalPages)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupDots(totalPages: Int) {
        stackView.spacing = spacing
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        for i in 0..<totalPages {
            let dot = UIView()
            dot.backgroundColor = i == 0 ? activeColor : inactiveColor
            dot.layer.cornerRadius = dotSize / 2
            dot.tag = i
            stackView.addArrangedSubview(dot)
            dotViews.append(dot)

            dot.snp.makeConstraints { make in
                make.height.equalTo(dotSize)
                make.width.equalTo(i == 0 ? activeDotWidth : dotSize)
            }
        }
    }

    private func updateDotsAppearance() {
        guard !dotViews.isEmpty else { return }
        for (index, dot) in dotViews.enumerated() {
            let isSelected = index == currentPage
            dot.backgroundColor = isSelected ? activeColor : inactiveColor
            dot.layer.cornerRadius = dotSize / 2
            dot.snp.updateConstraints { make in
                make.height.equalTo(dotSize)
                make.width.equalTo(isSelected ? activeDotWidth : dotSize)
            }
        }
        stackView.spacing = spacing
        stackView.layoutIfNeeded()
    }

    public func update(currentPage: Int) {
        guard currentPage >= 0, currentPage < dotViews.count else { return }
        self.currentPage = currentPage
        for (index, dot) in dotViews.enumerated() {
            let isSelected = index == currentPage

            dot.snp.updateConstraints { make in
                make.width.equalTo(isSelected ? activeDotWidth : dotSize)
            }

            UIView.animate(withDuration: 0.2) {
                dot.backgroundColor = isSelected ? self.activeColor : self.inactiveColor
                self.stackView.layoutIfNeeded()
            }
        }
    }
}
