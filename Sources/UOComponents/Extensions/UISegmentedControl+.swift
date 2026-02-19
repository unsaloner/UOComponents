//
//  UISegmentedControl+.swift
//  UOComponents
//
//  Created by Ünsal Öner on 14.02.2026.
//

import UIKit

public extension UISegmentedControl {
    static func builder(items: [Any]? = nil) -> UOSegmentedControlBuilder {
        UOSegmentedControlBuilder(items: items)
    }
}
