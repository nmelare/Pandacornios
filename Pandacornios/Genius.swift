//
//  Genius.swift
//  Pandacornios
//
//  Created by Luiza Fattori on 10/10/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//

import SpriteKit
import GameplayKit

class Genius: SKScene {
    var coinOff: SKSpriteNode = SKSpriteNode(imageNamed: "coin_00")
    var coinOn: SKSpriteNode = SKSpriteNode(imageNamed: "coin_01")
    var vaseOff: SKSpriteNode = SKSpriteNode(imageNamed: "vaso")
    var vaseOn: SKSpriteNode = SKSpriteNode(imageNamed: "Plantinha1")
    var sequel: [SKSpriteNode] = []

//    Quando a cena carregar, você faz isso:
    override func sceneDidLoad() {
        self.setUpCoinOff()
        self.setUpVaseOff()
    }

    func setUpCoinOff() {
        self.addChild(coinOff)
        coinOff.position = CGPoint(x: size.width / 2, y: size.height * 0.55)
        coinOff.size = CGSize(width: size.width * 0.2, height: size.height * 0.15)
    }

    func setUpCoinOn() {
        self.addChild(coinOn)
        coinOn.position = CGPoint(x: size.width / 4, y: size.height / 4)
        coinOn.size = CGSize(width: size.width * 0.5, height: size.height * 0.5)
    }

    func setUpVaseOff() {
        self.addChild(vaseOff)
        vaseOff.position = CGPoint(x: size.width / 2, y: size.height * 0.45)
        vaseOff.size = CGSize(width: size.width * 0.15, height: size.height * 0.06)
    }

    func setUpVaseOn() {
    self.addChild(vaseOn)
    vaseOn.position = CGPoint(x: size.width / 4, y: size.height / 4)
    vaseOn.size = CGSize(width: size.width * 0.15, height: size.height * 0.06)
    }

}
