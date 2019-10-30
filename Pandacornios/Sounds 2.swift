//
//  Sounds.swift
//  Pandacornios
//
//  Created by Tamara Erlij on 24/10/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Sounds {
    public static func storySound() -> SKAudioNode? {
        if let musicURL = Bundle.main.url(forResource: "entrada", withExtension: ".mp3") {
            let backgroundMusic = SKAudioNode(url: musicURL)
//            backgroundMusic.run(SKAction.playSoundFileNamed("entrada", waitForCompletion: false))
            backgroundMusic.isPositional = false
            backgroundMusic.autoplayLooped = true
            return backgroundMusic
        }
        return nil
    }
}
