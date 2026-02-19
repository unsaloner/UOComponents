//
//  UOSettingsDelegate.swift
//  UOComponents
//
//  Created by Ünsal Öner on 16.02.2026.
//

import UIKit

public protocol UOSettingsDelegate: AnyObject {
    func settingsDidTapRateApp(_ controller: UOSettingsViewController)
    func settingsDidTapShareApp(_ controller: UOSettingsViewController)
    func settingsDidTapSupport(_ controller: UOSettingsViewController)
    func settingsDidTapRestorePurchases(_ controller: UOSettingsViewController)
    func settingsDidTapDeleteAccount(_ controller: UOSettingsViewController)
    func settingsDidTapCopyUserId(_ controller: UOSettingsViewController)
}
