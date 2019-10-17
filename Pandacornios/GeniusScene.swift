//
//  Genius.swift
//  Pandacornios
//
//  Created by Luiza Fattori on 10/10/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVKit

class GeniusScene: SKScene {
    // Atlas
    var redRetangleAtlas: SKTextureAtlas = SKTextureAtlas(named: "redRetangle")
    var yellowRetangleAtlas: SKTextureAtlas = SKTextureAtlas(named: "yellowRetangle")
    var greenRetangleAtlas: SKTextureAtlas = SKTextureAtlas(named: "greenRetangle")
    var blueRetangleAtlas: SKTextureAtlas = SKTextureAtlas(named: "blueRetangle")

    // Nodes
    var redRetangleOff: SKSpriteNode = SKSpriteNode(imageNamed: "redRetangleOff")
    var yellowRetangleOff: SKSpriteNode = SKSpriteNode(imageNamed: "yellowRetangleOff")
    var greenRetangleOff: SKSpriteNode = SKSpriteNode(imageNamed: "greenRetangleOff")
    var blueRetangleOff: SKSpriteNode = SKSpriteNode(imageNamed: "blueRetangleOff")
    var buttonPlay: SKSpriteNode = SKSpriteNode(imageNamed: "coin_00")

    // Arrays
    var buttonsOptions: [SKSpriteNode] = []
    var gameSequel: [SKSpriteNode] = []
    var playerSequel: [SKSpriteNode] = []

    //Quando a cena carregar, você faz isso:
    override func sceneDidLoad() {

        self.setUpRedRetangelOff()
        self.setUpBlueRetangelOff()
        self.setUpGreenRetangelOff()
        self.setUpYellowRetangelOff()
        self.setUpPlayButton()

        self.buttonsOptions = [blueRetangleOff, redRetangleOff, yellowRetangleOff, greenRetangleOff]
    }

    func setUpRedRetangelOff() {
        self.addChild(redRetangleOff)
        redRetangleOff.position = CGPoint(x: size.width / 2.5, y: size.height * 0.55)
    }

    func setUpYellowRetangelOff() {
        self.addChild(yellowRetangleOff)
        yellowRetangleOff.position = CGPoint(x: size.width / 2.5, y: size.height * 0.45)
    }

    func setUpGreenRetangelOff() {
        self.addChild(greenRetangleOff)
        greenRetangleOff.position = CGPoint(x: size.width / 1.65, y: size.height * 0.55)
    }

    func setUpBlueRetangelOff() {
        self.addChild(blueRetangleOff)
        blueRetangleOff.position = CGPoint(x: size.width / 1.65, y: size.height * 0.45)
    }

    func setUpPlayButton() {
        self.addChild(buttonPlay)
        buttonPlay.position = CGPoint(x: size.width / 2, y: size.height / 1.5)
        buttonPlay.size = CGSize(width: size.width / 4, height: size.height / 4)
    }

    override var isUserInteractionEnabled: Bool {
        get {
            return true
        }
        set { // quando ignoramos o toque

        }
    }

    func playGame() {
        gameSequel = []
        var elementOfTheSequel = buttonsOptions.randomElement()
        gameSequel.append(elementOfTheSequel!)

    }

    func playSequel() {
        SKAction.animate(with: <#T##[SKTexture]#>, timePerFrame: <#T##TimeInterval#>)
    }

// Se o toque começou
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first
            else {
                return
        }
        let location = touch.location(in: self)

    }

}
