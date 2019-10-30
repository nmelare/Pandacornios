//
//  SpaceInvaders.swift
//  Pandacornios
//
//  Created by Rayane Xavier on 23/10/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//

import SpriteKit

class SpaceInvaders: SKScene, SKPhysicsContactDelegate {
    
    // MARK: Outlets
    // Nodes
    var ship: SKSpriteNode = SKSpriteNode(imageNamed: "nave.png")
    
    let heart0: SKSpriteNode = SKSpriteNode(imageNamed: "coracao.png")
    
    let heart1: SKSpriteNode = SKSpriteNode(imageNamed: "coracao.png")
    
    let heart2: SKSpriteNode = SKSpriteNode(imageNamed: "coracao.png")
    
    
    // Timer
    var shipFireTimer: Timer?
    
    var timeOfLastMove: CFTimeInterval = 0.0

    var timePerMove: CFTimeInterval = 0.4
    
    var contentCreated = false
    
    
    // Moviment Invader
    var invaderMovementDirection: InvaderMovementDirection = .right

    // Contact
    var contactQueue = [SKPhysicsContact]()
      
    // Life
    var shipLife: Float = 1.0
        
    // Game Over
    var gameEnding: Bool = false
    
    // Invaders Type
    let kMinInvaderBottomHeight: Float = 80.0

    enum InvaderType {

    var quitButton: SKSpriteNode = SKSpriteNode(imageNamed: "quit_button")
  
  enum InvaderType {

    case a
    case b
    case c
        
    static var size: CGSize {
        return CGSize(width: 24, height: 16)
    }
    
    static var name: String {
      return "invader"
    }
  }
  
  enum InvaderMovementDirection {
    case right
    case left
    case downThenRight
    case downThenLeft
    case none
  }
  
    // Bullet
  enum BulletType {
    case shipFired
    case invaderFired
  }
  
    // Textures
  let kInvaderGridSpacing = CGSize(width: 25, height: 30)
  let kInvaderRowCount = 6
  let kInvaderColCount = 6
  
  let kShipSize = CGSize(width: 30, height: 16)
  let kShipName = "nave"
  
  let kHealthHudName = "healthHud"
  
  let kShipFiredBulletName = "shipFiredBullet"
  let kInvaderFiredBulletName = "invaderFiredBullet"
  let kBulletSize = CGSize(width:4, height: 8)
  
  let kInvaderCategory: UInt32 = 0x1 << 0
  let kShipFiredBulletCategory: UInt32 = 0x1 << 1
  let kShipCategory: UInt32 = 0x1 << 2
  let kSceneEdgeCategory: UInt32 = 0x1 << 3
  let kInvaderFiredBulletCategory: UInt32 = 0x1 << 4
  

  // MARK: didMove

  // Object Lifecycle Management
  
  // Scene Setup and Content Creation
    override func sceneDidLoad() {
        self.setUpQuitButton()
    }

  override func didMove(to view: SKView) {
    
    if (!self.contentCreated) {
      self.createContent()
      self.contentCreated = true
      physicsWorld.contactDelegate = self
    }
  }
  
    // MARK: Create Content
  func createContent() {
    
    // Word Physic
    physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    physicsBody!.categoryBitMask = kSceneEdgeCategory
    
    // Time the fire ship
    shipFireTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) {_ in
        self.fireShipBullets()
    }
    
    setupInvaders()
    setupShip()
    setupLife()
    
    // black space color
    self.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
  }
  
    // Mark: Invader Textures

  func loadInvaderTextures(ofType invaderType: InvaderType) -> [SKTexture] {
    
    var prefix: String
    
    // Lines of invaders
    switch(invaderType) {
    case .a:
        prefix = "Rosa"
    case .b:
        prefix = "Verde"
    case .c:
        prefix = "Rosa"
    }
    
    // Arms invaders move
    return [SKTexture(imageNamed: String(format: "%@_00.png", prefix)),
            SKTexture(imageNamed: String(format: "%@_01.png", prefix))]
  }

    // MARK: Creat invaders
  func makeInvader(ofType invaderType: InvaderType) -> SKNode {
    
    // Textures
    let invaderTextures = loadInvaderTextures(ofType: invaderType)
    
    
    // Nodes
    let invader = SKSpriteNode(texture: invaderTextures[0])
    invader.name = InvaderType.name
    
    // Movement
    invader.run(SKAction.repeatForever(SKAction.animate(with: invaderTextures, timePerFrame: timePerMove)))
    
    // Invaders' bitmasks setup
    invader.physicsBody = SKPhysicsBody(rectangleOf: invader.frame.size)
    invader.physicsBody!.isDynamic = false
    invader.physicsBody!.categoryBitMask = kInvaderCategory
    invader.physicsBody!.contactTestBitMask = 0x0
    invader.physicsBody!.collisionBitMask = 0x0
    invader.size = CGSize(width: invader.size.width * 1.3, height: invader.size.height * 1.3)
    
    return invader
  }
  
    // MARK: Setup invaders
  func setupInvaders() {
    
    // Firs place in the screen
    let baseOrigin = CGPoint(x: size.width / 3, y: size.height / 1.7)
    
    // Line interleaving
    for row in 0..<kInvaderRowCount {
      
      var invaderType: InvaderType
      
      if row % 2 == 0 {
        invaderType = .a
      } else {
        invaderType = .b
      }
      
      // Modification of the invader line
        let invaderPositionY = CGFloat(row) * (InvaderType.size.height * 2) + baseOrigin.y
      
      var invaderPosition = CGPoint(x: baseOrigin.x, y: invaderPositionY)
      
      // Invaders row count
      for _ in 1..<kInvaderRowCount {
        
        // Make invader on the screen
        let invader = makeInvader(ofType: invaderType)
        invader.position = invaderPosition
        
        addChild(invader)
        
        invaderPosition = CGPoint(
          x: invaderPosition.x + InvaderType.size.width + kInvaderGridSpacing.width,
          y: invaderPositionY
        )
      }
    }
  }
  
    // MARK: Ship
  func setupShip() {
    // Node of the ship
    ship = makeShip() as! SKSpriteNode
    
    // Setup ship position
    ship.position = CGPoint(x: size.width / 2.0, y: kShipSize.height / 2.0 + 80)
    addChild(ship)
  }
  
    // MARK: Make Ship
  func makeShip() -> SKNode {
    
    // Attributes
    ship = SKSpriteNode(imageNamed: "nave.png")
    ship.name = kShipName
    
    // Sizes
    ship.physicsBody = SKPhysicsBody(rectangleOf: ship.frame.size)
    ship.size = CGSize(width: ship.size.width * 1.7, height: ship.size.height * 1.7)
    
    // Physysics Body
    ship.physicsBody!.isDynamic = true

    // Gravity
    ship.physicsBody!.affectedByGravity = false

    // Mass
    ship.physicsBody!.mass = 0.02
    
    // Setup bit mask
    ship.physicsBody!.categoryBitMask = kShipCategory
    
    // Contact bit mask
    ship.physicsBody!.contactTestBitMask = 0x0
    
    // Collision bit mask
    ship.physicsBody!.collisionBitMask = kSceneEdgeCategory
    
    return ship
  }
  
    // MARK: Life ship
  func setupLife() {
    
    // Life label
    let healthLabel = SKLabelNode(fontNamed: "Silkscreen Expanded")
    healthLabel.name = kHealthHudName
    healthLabel.fontSize = 28
    healthLabel.fontColor = #colorLiteral(red: 1, green: 0.737254902, blue: 0.8431372549, alpha: 1)
    healthLabel.text = String(format: "Vida: ", shipLife * 100.0)
    
    // Life label position
    healthLabel.position = CGPoint(
      x: frame.size.width - 135,
      y: size.height - (70 + healthLabel.frame.size.height/2)
    )
    addChild(healthLabel)
    
    // Hearts position
    
    // heart 0
    heart0.position = CGPoint(
        x: frame.size.width - 70,
        y: size.height - (60 + healthLabel.frame.size.height/2)
    )
    heart0.size = CGSize(width: 20, height: 17)
    addChild(heart0)
    
    // heart 1
    heart1.position = CGPoint(
        x: frame.size.width - 45,
        y: size.height - (60 + healthLabel.frame.size.height/2)
    )
    heart1.size = CGSize(width: 20, height: 17)
    addChild(heart1)
    
    // heart 2
    heart2.position = CGPoint(
        x: frame.size.width - 20,
        y: size.height - (60 + healthLabel.frame.size.height/2)
    )
    heart2.size = CGSize(width: 20, height: 17)
    addChild(heart2)

  }

    // Adjust life ship
  func adjustShipHealth(by healthAdjustment: Float) {
    // 1
    shipLife = max(shipLife + healthAdjustment, 0)
    
    if heart2.size == CGSize(width: 20, height: 17) {
        heart2.removeFromParent()
        heart2.size = CGSize(width: 0, height: 0)
    } else {
        heart1.removeFromParent()
    }
  }
  
    // MASK: Bullets
    
  func makeBullet(ofType bulletType: BulletType) -> SKNode {
    var bullet: SKNode
    
    switch bulletType {
    
    // Ship fired
    case .shipFired:
      bullet = SKSpriteNode(color: SKColor.green, size: kBulletSize)
      bullet.name = kShipFiredBulletName
      
      bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.frame.size)
      bullet.physicsBody!.isDynamic = true
      bullet.physicsBody!.affectedByGravity = false
      bullet.physicsBody!.categoryBitMask = kShipFiredBulletCategory
      bullet.physicsBody!.contactTestBitMask = kInvaderCategory
      bullet.physicsBody!.collisionBitMask = 0x0
    
    // Invader fired
    case .invaderFired:
      bullet = SKSpriteNode(color: SKColor.magenta, size: kBulletSize)
      bullet.name = kInvaderFiredBulletName
      
      bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.frame.size)
      bullet.physicsBody!.isDynamic = true
      bullet.physicsBody!.affectedByGravity = false
      bullet.physicsBody!.categoryBitMask = kInvaderFiredBulletCategory
      bullet.physicsBody!.contactTestBitMask = kShipCategory
      bullet.physicsBody!.collisionBitMask = 0x0
      break
    }
    
    return bullet
  }
  
  // MARK: Scene Update
  func moveInvaders(forUpdate currentTime: CFTimeInterval) {
    
    // Motion time
    if (currentTime - timeOfLastMove < timePerMove) {
      return
    }
    
    determineInvaderMovementDirection()
    
    // Invader movement direction
    enumerateChildNodes(withName: InvaderType.name) { node, stop in
      switch self.invaderMovementDirection {
      case .right:
        node.position = CGPoint(x: node.position.x + 10, y: node.position.y)
      case .left:
        node.position = CGPoint(x: node.position.x - 10, y: node.position.y)
      case .downThenLeft, .downThenRight:
        node.position = CGPoint(x: node.position.x, y: node.position.y - 10)
      case .none:
        break
      }
      
      // Mack move
      self.timeOfLastMove = currentTime
    }
  }
  
    // MARK: Adjust Invader Movement
  func adjustInvaderMovement(to timePerMove: CFTimeInterval) {
    
    // Time per move
    if self.timePerMove <= 0 {
      return
    }
    
    // Ratio
    let ratio: CGFloat = CGFloat(self.timePerMove / timePerMove)
    self.timePerMove = timePerMove
    
    // Mave speed proportion
    enumerateChildNodes(withName: InvaderType.name) { node, stop in
      node.speed = node.speed * ratio
    }
  }
    
  //MARK: Invader Bullets
  func fireInvaderBullets(forUpdate currentTime: CFTimeInterval) {
    
    // Setup bullets
    let existingBullet = childNode(withName: kInvaderFiredBulletName)
    
    // Make array of invaders
    if existingBullet == nil {
      var allInvaders = [SKNode]()
      
      // Make node
      enumerateChildNodes(withName: InvaderType.name) { node, stop in
        allInvaders.append(node)
      }
      
      if allInvaders.count > 0 {
        
        // Choose a random invader
        let allInvadersIndex = Int(arc4random_uniform(UInt32(allInvaders.count)))
        
        let invader = allInvaders[allInvadersIndex]
        
        // Make position
        let bullet = makeBullet(ofType: .invaderFired)
        bullet.position = CGPoint(
          x: invader.position.x,
          y: invader.position.y - invader.frame.size.height / 2 + bullet.frame.size.height / 2
        )
        
        // Bullet destination
        let bulletDestination = CGPoint(x: invader.position.x, y: -(bullet.frame.size.height / 2))
        
        // Setup attributes
        fireBullet(
          bullet: bullet,
          toDestination: bulletDestination,
          withDuration: 2.0,
          andSoundFileName: "invadersSound.wav"
        )
      }
    }
  }
  
    // MARK: Contacts
  func processContacts(forUpdate currentTime: CFTimeInterval) {
    
    for contact in contactQueue {
      handle(contact)
      
        // Bullet in invaders
      if let index = contactQueue.firstIndex(of: contact) {
        contactQueue.remove(at: index)
      }
    }
  }
  
    // MARK: Update
  override func update(_ currentTime: TimeInterval) {
    if isGameOver() {
        MiniGamesController.shared.spaceInvadersWasPlayed = true
        endGame()
    }
    
    moveInvaders(forUpdate: currentTime)
    fireInvaderBullets(forUpdate: currentTime)
    processContacts(forUpdate: currentTime)
  }
  
  
  // MARK: Invaders Types of Movement
  func determineInvaderMovementDirection() {
    // Movement Direction
    var proposedMovementDirection: InvaderMovementDirection = invaderMovementDirection
    
    // Node of Invaders
    enumerateChildNodes(withName: InvaderType.name) { node, stop in
      
      switch self.invaderMovementDirection {
      case .right:
        //Make down in right
        if (node.frame.maxX >= node.scene!.size.width - 1.0) {
          proposedMovementDirection = .downThenLeft
          
          // Add the following line
          self.adjustInvaderMovement(to: self.timePerMove * 0.8)
          
          stop.pointee = true
        }
      case .left:
        //Make down in left
        if (node.frame.minX <= 1.0) {
          proposedMovementDirection = .downThenRight
          
          // Add the following line
          self.adjustInvaderMovement(to: self.timePerMove * 0.8)
          
          stop.pointee = true
        }
        
      // Movement direction
      case .downThenLeft:
        proposedMovementDirection = .left
        
        stop.pointee = true
        
      case .downThenRight:
        proposedMovementDirection = .right
        
        stop.pointee = true
        
      default:
        break
      }
      
    }
    
    //Setup movement
    if (proposedMovementDirection != invaderMovementDirection) {
      invaderMovementDirection = proposedMovementDirection
    }
  }
  
  // MARK: Bullet Actions
  func fireBullet(bullet: SKNode, toDestination destination: CGPoint, withDuration duration: CFTimeInterval, andSoundFileName soundName: String) {
    // Bullet actions
    let bulletAction = SKAction.sequence([
      SKAction.move(to: destination, duration: duration),
      SKAction.wait(forDuration: 3.0 / 60.0),
      SKAction.removeFromParent()
      ])
    
    // Bullet Sound
    let soundAction = SKAction.playSoundFileNamed(soundName, waitForCompletion: true)
    
    // Bullet Run
    bullet.run(SKAction.group([bulletAction, soundAction]))
    
    addChild(bullet)
  }

    // MARK: Ship Bullets
  func fireShipBullets() {
    // Setup bullets
    let existingBullet = childNode(withName: kShipFiredBulletName)
    
    // Nodes bullets
    if existingBullet == nil {
        if let ship = childNode(withName: kShipName){
            let bullet = makeBullet(ofType: .shipFired)
            
                // Make position
            bullet.position = CGPoint(
              x: ship.position.x,
              y: ship.position.y + ship.frame.size.height - bullet.frame.size.height / 2
            )

            // Bullets destination
            let bulletDestination = CGPoint(
              x: ship.position.x,
              y: frame.size.height + bullet.frame.size.height / 2
            )
            // Setup Bullets
            fireBullet(
              bullet: bullet,
              toDestination: bulletDestination,
              withDuration: 1.0,
              andSoundFileName: "shipSound.wav"
            )
        }
    }
  }
    
    // MARK: Touches Funcions
    func touchDown(atPoint: CGPoint) {
      
      ship.position.x = atPoint.x
      }
  
    func touchMoved(toPoint: CGPoint) {
      ship.position.x = toPoint.x
      
    }
  
    func touchUp (atPoint: CGPoint) {
      ship.position.x = atPoint.x
    }

    func setUpQuitButton() {
        self.addChild(quitButton)
        quitButton.position = CGPoint(x: size.width * 0.1, y: size.height * 0.90)
        quitButton.size = CGSize (width: size.width * 0.15, height: size.height * 0.085)
        quitButton.name = "QuitButton"
    }
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          for t in touches { touchDown(atPoint: t.location(in:self))
          }
        
        guard let touch = touches.first
            else {
                return
        }

        let location = touch.location(in: self)

        guard let frontTouchedNode = self.atPoint(location) as? SKSpriteNode else { return }

        if frontTouchedNode.name == "QuitButton" {
            let gameScene = InicialScreen(size: self.size)
            self.view?.presentScene(gameScene,transition: SKTransition.doorsOpenVertical(withDuration: 1.0))
        }
    }
  
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      for t in touches { touchMoved(toPoint: t.location(in: self))}
    }
    
  // MARK: User Tap Helpers
  
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self))}
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self))}
    }
  
  // MARK: Physics Contact Helpers
  
  func didBegin(_ contact: SKPhysicsContact) {
    contactQueue.append(contact)
  }

  func handle(_ contact: SKPhysicsContact) {
    // Ensure you haven't already handled this contact and removed its nodes
    if contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil {
      return
    }
    
    let nodeNames = [contact.bodyA.node!.name!, contact.bodyB.node!.name!]
    
    if nodeNames.contains(kShipName) && nodeNames.contains(kInvaderFiredBulletName) {
      
        // Invader bullet hit a ship
      run(SKAction.playSoundFileNamed("ShipHit.wav", waitForCompletion: false))
      
      // Alpha of the ship declinate
      adjustShipHealth(by: -0.334)
      
      if shipLife <= 0.0 {
        // Remove the bodys in contact
        contact.bodyA.node!.removeFromParent()
        contact.bodyB.node!.removeFromParent()
      } else {
        // Make alpha of the ship change
        ship = childNode(withName: kShipName) as! SKSpriteNode; do {
          ship.alpha = CGFloat(shipLife)
          
          if contact.bodyA.node == ship {
            contact.bodyB.node!.removeFromParent()
            
          } else {
            contact.bodyA.node!.removeFromParent()
          }
        }
      }
      
    } else if nodeNames.contains(InvaderType.name) && nodeNames.contains(kShipFiredBulletName) {
      // Ship bullet hit an invader
      run(SKAction.playSoundFileNamed("InvaderHit.wav", waitForCompletion: false))
      contact.bodyA.node!.removeFromParent()
      contact.bodyB.node!.removeFromParent()
      
    }
  }
  
  // MARK: Game End Helpers
  
  func isGameOver() -> Bool {
    // Calling the invader
    let invader = childNode(withName: InvaderType.name)
    
    // Height of invader
    var invaderTooLow = false
    
    enumerateChildNodes(withName: InvaderType.name) { node, stop in
      
      if (Float(node.frame.minY) <= self.kMinInvaderBottomHeight)   {
        invaderTooLow = true
        stop.pointee = true
      }
    }
    
    // Calling the ship
    let ship = childNode(withName: kShipName)
    
    // Proving ways to lose
    return invader == nil || invaderTooLow || ship == nil
  }

    // MARK: End Game
  func endGame() {
    // Proving
    if !gameEnding {
      
      gameEnding = true
      
      // Make go to another page
      let gameOverScene: GameOverSceneSpace = GameOverSceneSpace(size: size)
      
      view?.presentScene(gameOverScene, transition: SKTransition.doorsOpenHorizontal(withDuration: 1.0))
    }
  }
  
}
