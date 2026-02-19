//
//  UOOnboardingVideoManager.swift
//  UOComponents
//
//  Created by Ünsal Öner on 14.02.2026.
//

import AVFoundation
import UIKit

final class UOOnboardingVideoManager {

    private var players: [AVQueuePlayer] = []
    private var loopers: [AVPlayerLooper] = []

    init(pages: [UOOnboardingPage]) {
        setupPlayers(for: pages)
    }

    public func player(at index: Int) -> AVQueuePlayer? {
        guard index < players.count else { return nil }
        return players[index]
    }

    public func cleanup() {
        players.forEach { $0.pause() }
        players.removeAll()
        loopers.removeAll()
    }

    private func setupPlayers(for pages: [UOOnboardingPage]) {
        for page in pages {
            guard let url = Bundle.main.url(forResource: page.mediaName, withExtension: "mp4") else {
                players.append(AVQueuePlayer())
                continue
            }

            let asset = AVURLAsset(url: url)
            asset.loadValuesAsynchronously(forKeys: ["playable", "tracks"]) {}

            let item = AVPlayerItem(asset: asset)
            item.preferredForwardBufferDuration = 2

            let player = AVQueuePlayer(playerItem: item)
            player.isMuted = true
            player.automaticallyWaitsToMinimizeStalling = false

            let looper = AVPlayerLooper(player: player, templateItem: item)

            players.append(player)
            loopers.append(looper)

            player.play()
        }
    }
}
