//
//  UOLabelBuilder.swift
//  UOComponents
//
//  Created by Ünsal Öner on 12.02.2026.
//

import UIKit

public final class UOLabelBuilder: UOBaseComponentBuilder<UILabel> {

    public init() {
        super.init(view: UILabel())
        view.numberOfLines = 0
    }
}

public extension UOLabelBuilder {

    @discardableResult
    public func text(_ text: String?) -> Self {
        view.text = text
        return self
    }
    
    @discardableResult
    public func attributedText(_ text: NSAttributedString?) -> Self {
        view.attributedText = text
        return self
    }
    
    @discardableResult
    public func textColor(_ color: UIColor) -> Self {
        view.textColor = color
        return self
    }
    
    @discardableResult
    public func font(_ font: UIFont) -> Self {
        view.font = font
        view.adjustsFontForContentSizeCategory = true
        return self
    }
    
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment) -> Self {
        view.textAlignment = alignment
        return self
    }
    
    @discardableResult
    public func lines(_ count: Int) -> Self {
        view.numberOfLines = count
        return self
    }
    
    @discardableResult
    public func lineBreak(_ mode: NSLineBreakMode) -> Self {
        view.lineBreakMode = mode
        return self
    }

    @discardableResult
    public func minimumScaleFactor(_ factor: CGFloat) -> Self {
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = factor
        return self
    }

    @discardableResult
    public func adjustsFontSizeToFitWidth(_ adjusts: Bool) -> Self {
        view.adjustsFontSizeToFitWidth = adjusts
        return self
    }
}
