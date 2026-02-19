//
//  UOFonts.swift
//  UOComponents
//
//  Created by Ünsal Öner on 12.02.2026.
//

import UIKit

public enum UOFont {

    public static func largeTitle(_ size: CGFloat = 28) -> UIFont {
        UIFont(name: "Montserrat-Bold", size: size) ?? .systemFont(ofSize: size, weight: .bold)
    }

    public static func title(_ size: CGFloat = 22) -> UIFont {
        UIFont(name: "Montserrat-SemiBold", size: size) ?? .systemFont(ofSize: size, weight: .semibold)
    }

    public static func subtitle(_ size: CGFloat = 18) -> UIFont {
        UIFont(name: "Montserrat-Medium", size: size) ?? .systemFont(ofSize: size, weight: .medium)
    }
    
    public static func body(_ size: CGFloat = 16) -> UIFont {
        UIFont(name: "Montserrat-Regular", size: size) ?? .systemFont(ofSize: size, weight: .regular)
    }

    public static func bodyMedium(_ size: CGFloat = 16) -> UIFont {
        UIFont(name: "Montserrat-Medium", size: size) ?? .systemFont(ofSize: size, weight: .medium)
    }

    public static func caption(_ size: CGFloat = 14) -> UIFont {
        UIFont(name: "Montserrat-Regular", size: size) ?? .systemFont(ofSize: size, weight: .regular)
    }
    
    public static func button(_ size: CGFloat = 17) -> UIFont {
        UIFont(name: "Montserrat-Bold", size: size) ?? .systemFont(ofSize: size, weight: .bold)
    }
}

