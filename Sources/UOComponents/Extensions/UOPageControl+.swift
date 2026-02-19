//
//  UOPageControl+.swift
//  UOComponents
//
//  Created by Ünsal Öner on 16.02.2026.
//

import UIKit

public extension UOPageControl {

    static func builder(totalPages: Int) -> UOPageControlBuilder {
        UOPageControlBuilder(totalPages: totalPages)
    }
}
