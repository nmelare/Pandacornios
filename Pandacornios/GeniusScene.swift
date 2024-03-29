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
    var endGame: Bool = false
    // MARK: Outlets
    // Player
    var playerTouch = 0
    var playerTurn: Bool = false

    // Atlas
    var redButtonAtlas: SKTextureAtlas = SKTextureAtlas(named: "redButton")
    var yellowButtonAtlas: SKTextureAtlas = SKTextureAtlas(named: "yellowButton")
    var greenButtonAtlas: SKTextureAtlas = SKTextureAtlas(named: "greenButton")
    var blueButtonAtlas: SKTextureAtlas = SKTextureAtlas(named: "blueButton")

    // Nodes
    var redButtonOff: SKSpriteNode = SKSpriteNode(imageNamed: "redButton")
    var yellowButtonOff: SKSpriteNode = SKSpriteNode(imageNamed: "yellowButton")
    var greenButtonOff: SKSpriteNode = SKSpriteNode(imageNamed: "greenButton")
    var blueButtonOff: SKSpriteNode = SKSpriteNode(imageNamed: "blueButton")
    var playButton: SKSpriteNode = SKSpriteNode(imageNamed: "play_button")

    // Arrays
    var buttonsOptions: [SKSpriteNode] = []
    var gameSequel: [SKSpriteNode] = []
    var playerSequel: [SKSpriteNode] = []
    
    // Souns
    var soundBlue: AVAudioPlayer!
    var soundGreen: AVAudioPlayer!
    var soundRed: AVAudioPlayer!
    var soundYellow: AVAudioPlayer!

    // MARK: scineDidLoad
    override func sceneDidLoad() {

        self.setUpRedButtonOff()
        self.setUpBlueButtonOff()
        self.setUpGreenButtonOff()
        self.setUpYellowButtonOff()
        self.setUpPlayButton()

        self.buttonsOptions = [blueButtonOff, redButtonOff, yellowButtonOff, greenButtonOff]
    }
    // MARK: Set Up Button
    func setUpRedButtonOff() {
        self.addChild(redButtonOff)
        redButtonOff.position = CGPoint(x: size.width * 0.72, y: size.height * 0.67)
        redButtonOff.size = CGSize(width: size.width * 0.42, height: size.height * 0.23)
        redButtonOff.name = "RedButton"
        audioGeniusRed()
    }

    func setUpYellowButtonOff() {
        self.addChild(yellowButtonOff)
        yellowButtonOff.position = CGPoint(x: size.width * 0.3, y: size.height * 0.45)
        yellowButtonOff.size = CGSize(width: size.width * 0.42, height: size.height * 0.23)
        yellowButtonOff.name = "YellowButton"
        audioGeniusYellow()
    }

    func setUpGreenButtonOff() {
        self.addChild(greenButtonOff)
        greenButtonOff.position = CGPoint(x: size.width * 0.3, y: size.height * 0.67)
        greenButtonOff.size = CGSize(width: size.width * 0.42, height: size.height * 0.23)
        greenButtonOff.name = "GreenButton"
        audioGeniusGreen()
    }

    func setUpBlueButtonOff() {
        self.addChild(blueButtonOff)
        blueButtonOff.position = CGPoint(x: size.width * 0.72, y: size.height * 0.45)
        blueButtonOff.size = CGSize(width: size.width * 0.42, height: size.height * 0.23)
        blueButtonOff.name = "BlueButton"
        audioGeniusBlue()
    }

    func setUpPlayButton() {
        self.addChild(playButton)
        playButton.position = CGPoint(x: size.width * 0.55, y: size.height * 0.56)
        playButton.size = CGSize(width: size.width / 7, height: size.height / 10)
        playButton.name = "PlayButton"
    }
    // MARK: Funcions
    func playGame() {
        let elementOfTheSequel = buttonsOptions.randomElement()
        gameSequel.append(elementOfTheSequel!)
    }
    // MARK: Animate Funcions
    func animate(animatedButtons: [SKSpriteNode], completion: @escaping () -> Void) {
        var actionList:[SKAction] = []
        for rect in animatedButtons {
            var atlas: SKTextureAtlas
            var soundFunc: () -> Void
            if rect.name == "GreenButton"{
                atlas = greenButtonAtlas
                soundFunc = audioGeniusGreen
            } else if rect.name == "BlueButton"{
                atlas = blueButtonAtlas
                soundFunc = audioGeniusBlue
            } else if rect.name == "YellowButton"{
                atlas = yellowButtonAtlas
                soundFunc = audioGeniusYellow
            } else {
                atlas = redButtonAtlas
                soundFunc = audioGeniusRed
            }

            let textureOfRetangles:[SKTexture] = loadFrames(atlas)

            let actionAndWait = SKAction.group([SKAction.run(SKAction.animate(with: textureOfRetangles, timePerFrame: 1 / TimeInterval(textureOfRetangles.count), resize: false, restore: true), onChildWithName: rect.name!), SKAction.run({ soundFunc() }),SKAction.wait(forDuration: 1.1)])
            actionList.append(actionAndWait)
        }
        run(SKAction.sequence(actionList), completion: completion)

    }

    func loadFrames(_ textureAtlas: SKTextureAtlas) -> [SKTexture] {

        var frames = [SKTexture]()
        let names = textureAtlas.textureNames.sorted()

        for i in 0...names.count-1 {
            let t = textureAtlas.textureNamed(names[i])
            t.filteringMode = .nearest
            frames.append(t)
        }
        return frames
    }

    func animateSequel() {
        self.animate(animatedButtons: gameSequel) {
            self.playerTurn = true
            self.playerTouch = 0
            self.resetPlayerGameSequel()
        }
    }
    //MARK: Reset Funcions
    func resetGame() {
        gameSequel = []
        playerSequel = []
    }

    func resetPlayerGameSequel() {
        playerSequel = []
    }
    
    func endingGameSetUp() {
        self.animate(animatedButtons: [self.redButtonOff], completion: {})
        self.animate(animatedButtons: [self.blueButtonOff], completion: {})
        self.animate(animatedButtons: [self.greenButtonOff], completion: {})
        self.animate(animatedButtons: [self.yellowButtonOff], completion: {})

        if !endGame {
      endGame = true

      let gameOverScene: GameOverSceneGenius = GameOverSceneGenius(size: size)

      view?.presentScene(gameOverScene, transition: SKTransition.doorsOpenVertical (withDuration: 1.0))
        }
    }
    // MARK: Touches Funcions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first
            else {
                return
        }

        let location = touch.location(in: self)

        guard let frontTouchedNode = self.atPoint(location) as? SKSpriteNode else { return }

        if frontTouchedNode.name == "PlayButton" {
            self.resetGame()
            self.playGame()
            self.animateSequel()
            return
        }
        // MARK: Conditional of Player's Turn
        if playerTurn == true {
            if buttonsOptions.contains(frontTouchedNode) {

                playerTurn = false
                animate(animatedButtons: [frontTouchedNode]) {
                    self.playerTurn = true
                    self.playerSequel.append(frontTouchedNode)

                    if self.playerSequel[self.playerTouch] == self.gameSequel[self.playerTouch] {
                        if self.playerTouch == self.gameSequel.count-1 {
                            self.playerTurn = false
                            self.playGame()
                            self.animateSequel()
                            return
                        }
                        self.playerTouch += 1
                    } else {
                        self.endingGameSetUp()
                        
                        
                        //                        self.resetPlayerGameSequel()
//                        self.resetGame()
                    }
                }
            }
        }
    }
    
    func audioGeniusBlue(){
        do{
            soundBlue = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "audioBlue", ofType: "mp3")!))
            soundBlue.prepareToPlay()
            soundBlue.play()
        } catch {
            print(error)
        }
    }
    
    func audioGeniusGreen(){
        do{
            soundGreen = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "audioGreen", ofType: "mp3")!))
            soundGreen.prepareToPlay()
            soundGreen.play()
        } catch {
            print(error)
        }
    }
    
    func audioGeniusRed(){
        do{
            soundRed = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "audioRed", ofType: "mp3")!))
            soundRed.prepareToPlay()
            soundRed.play()
        } catch {
            print(error)
        }
    }
    
    func audioGeniusYellow(){
        do{
            soundYellow = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "audioYellow", ofType: "mp3")!))
            soundYellow.prepareToPlay()
            soundYellow.play()
        } catch {
            print(error)
        }
    }
}
