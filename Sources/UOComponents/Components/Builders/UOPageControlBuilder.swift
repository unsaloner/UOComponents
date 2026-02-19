//
//  UOPageControlBuilder.swift
//  UOComponents
//
//  Created by Ünsal Öner on 16.02.2026.
//

import UIKit

public final class UOPageControlBuilder: UOBaseComponentBuilder<UOPageControl> {

    public init(totalPages: Int) {
        super.init(view: UOPageControl(totalPages: totalPages))
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

public extension UOPageControlBuilder {

    @discardableResult
    public func activeColor(_ color: UIColor) -> Self {
        view.activeColor = color
        return self
    }

    @discardableResult
    public func inactiveColor(_ color: UIColor) -> Self {
        view.inactiveColor = color
        return self
    }

    @discardableResult
    public func dotSize(_ value: CGFloat) -> Self {
        view.dotSize = value
        return self
    }

    @discardableResult
    public func activeDotWidth(_ value: CGFloat) -> Self {
        view.activeDotWidth = value
        return self
    }

    @discardableResult
    public func spacing(_ value: CGFloat) -> Self {
        view.spacing = value
        return self
    }
}
