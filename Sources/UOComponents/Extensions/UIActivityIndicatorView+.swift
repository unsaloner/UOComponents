//
//  UIActivityIndicatorView+.swift
//  UOComponents
//
//  Created by Ünsal Öner on 14.02.2026.
//

import UIKit

public extension UIActivityIndicatorView {
    static func builder(style: UIActivityIndicatorView.Style = .medium) -> UOActivityIndicatorBuilder {
        UOActivityIndicatorBuilder(style: style)
    }
}
