//
//  GameScene.swift
//  Wild West Shootout
//
//  Created by Anthony on 3/4/19.
//  Copyright © 2019 Anthony Caligure. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let player1 = SKSpriteNode(imageNamed:"leftCowboy1")
    let player2 = SKSpriteNode(imageNamed:"rightCowboy0")
    let tumbleweed = SKSpriteNode(imageNamed: "tumbleweed")
    
    let bullet2 = SKSpriteNode(imageNamed: "bullet")
    let bullet1 = SKSpriteNode(imageNamed: "bullet")
    
    let singleplayerButton = SKSpriteNode(imageNamed: "button")
    let multiplayerButton = SKSpriteNode(imageNamed: "button")
    
    var leftTimestamp = 0.0
        
    lazy var single: SKLabelNode = {
        var label = SKLabelNode()
        label.fontName = "Carnivalee Freakshow"
        label.fontSize = 65.0
        label.zPosition = 3
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.fontColor = SKColor.brown
        label.text = "Singleplayer"
        return label
    }()
    
    lazy var multi: SKLabelNode = {
        var label = SKLabelNode()
        label.fontName = "Carnivalee Freakshow"
        label.fontSize = 65.0
        label.zPosition = 3
        label.fontColor = SKColor.brown
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "Multiplayer"
        return label
    }()
    
    let gunSound = SKAction.playSoundFileNamed("gunshot.wav", waitForCompletion: false)
    let threeSound = SKAction.playSoundFileNamed("three.wav", waitForCompletion: true)
    let twoSound = SKAction.playSoundFileNamed("two.wav", waitForCompletion: true)
    let oneSound = SKAction.playSoundFileNamed("one.wav", waitForCompletion: true)
    let introSound = SKAction.playSoundFileNamed("introMusic.wav", waitForCompletion: true)
    
    var allowedToShoot = false
    var startedCount = false
    var gameOver = false
    
    var winner = 0
    
    var isSingleplayer = false
    
    lazy var countdownLabel: SKLabelNode = {
        var label = SKLabelNode()
        label.fontName = "Carnivalee Freakshow"
        label.fontSize = 200.0
        label.zPosition = 2
        label.fontColor = SKColor.brown
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "\(maxTime)"
        return label
    }()
    
    var labelText = 0;
    
    var counterTimer = Timer()
    var maxTime = 5
    
    var singlePlayerCPUMax = Int(arc4random_uniform(14)) + 8
    var currentWait = 0
    
    override func didMove(to view: SKView) {
        
        self.run(introSound)
        
        let background = SKSpriteNode(imageNamed: "background")
        background.setScale(0.1)
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        
        self.addChild(background)
        
        countdownLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        addChild(countdownLabel)
        
        countdownLabel.text = "Wild West Shootout!"
        
        player1.setScale(1.25)
        player1.position = CGPoint(x: self.size.width * 0.15, y: self.size.height * 0.30)
        player1.zPosition = 2
        
        self.addChild(player1)
        
        bullet1.setScale(5)
        
        bullet1.position = player1.position
        bullet1.zPosition = 1
        self.addChild(bullet1)
        
        player2.setScale(1.25)
        player2.position = CGPoint(x: self.size.width * 0.85, y: self.size.height * 0.30)
        player2.zPosition = 2
        
        self.addChild(player2)
        
        bullet2.setScale(5)
        
        bullet2.position = player2.position
        bullet2.zPosition = 1
        self.addChild(bullet2)
        
        tumbleweed.setScale(2.0)
        tumbleweed.position = CGPoint(x: self.size.width * 0.025 - tumbleweed.size.width, y: self.size.height * 0.20)
        tumbleweed.zPosition = 3
        
        self.addChild(tumbleweed)
        
        let rotate = SKAction.rotate(byAngle: -CGFloat.pi * 2, duration: 2.25)
        let rep = SKAction.repeatForever(rotate)
        let move = SKAction.moveTo(x: self.frame.size.width + tumbleweed.size.width, duration: 5.0)
        let delete = SKAction.removeFromParent()
        
        let group = SKAction.group([move,rep])
        
        let sequence = SKAction.sequence([group, delete])
        
        tumbleweed.run(sequence)
        
        singleplayerButton.setScale(2.0)
        singleplayerButton.position = CGPoint(x: self.size.width * 0.5 - singleplayerButton.size.width,
                                              y: self.size.height *  0.30)
        singleplayerButton.zPosition = 2
        self.addChild(singleplayerButton)
        
        single.position = CGPoint(x: self.size.width * 0.5 - singleplayerButton.size.width,
                                  y: self.size.height *  0.35)
        
        multiplayerButton.setScale(2.0)
        multiplayerButton.position = CGPoint(x: self.size.width * 0.5 + multiplayerButton.size.width,
                                              y: self.size.height *  0.30)
        
        multiplayerButton.zPosition = 2
        self.addChild(multiplayerButton)
        
        multi.position = CGPoint(x: self.size.width * 0.5 + multiplayerButton.size.width,
                                 y: self.size.height *  0.35)
        
        self.addChild(single)
        self.addChild(multi)
        
        
    }
    
    func startCount(){
        labelText = maxTime
        
        startedCount = true
        
        counterTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
        
    }
    
    @objc func decrementCounter(){
        
        if !allowedToShoot {
            
            if(labelText <= 1){
                
                allowedToShoot = true
                countdownLabel.text = "DRAW!"
                
                return
                
            }
        
            if(labelText == 4){
                
                let cS = SKAction.sequence([threeSound])
                self.run(cS)
                
            }else if(labelText == 3){
                
                let cS = SKAction.sequence([twoSound])
                self.run(cS)
                
            }else if(labelText == 2){
                
                let cS = SKAction.sequence([oneSound])
                self.run(cS)
                
            }
            
            
            labelText -= 1
            
            if(labelText != 4){
                countdownLabel.text = "\(labelText)"
            }
            
        
        }
        
    }
 
    
    func player1Shoot(){
        
        let moveBullet = SKAction.move(to: player2.position, duration: 0.1)
        let deleteBullet = SKAction.removeFromParent()
        
        player1.texture = SKTexture(imageNamed:"leftCowboy2")
        let bulletSequence = SKAction.sequence([gunSound, moveBullet, deleteBullet])
     
        bullet1.run(bulletSequence)
        
    }
    
    func player2Shoot(){
        
        let moveBullet = SKAction.move(to: player1.position, duration: 0.1)
        let deleteBullet = SKAction.removeFromParent()
        
        player2.texture = SKTexture(imageNamed:"pixil-frame-0")
        let bulletSequence = SKAction.sequence([gunSound, moveBullet, deleteBullet])
        
        bullet2.run(bulletSequence)
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var isRight : Bool = false
        var isLeft : Bool = false
        
        var rightTimestamp = 0.0
        
        for touch in touches{
            
            if singleplayerButton.contains(touch.location(in: self)){
                isSingleplayer = true
                
            }
            
            if(touch == touches.first && !startedCount){
                
                singleplayerButton.removeFromParent()
                multiplayerButton.removeFromParent()
                single.removeFromParent()
                multi.removeFromParent()
                startCount()
                
            }
            
            let location = touch.location(in: self)
            
            if(location.x < self.size.width/2){
                
                isLeft = true
                leftTimestamp = touch.timestamp
                
            }
            if(location.x > self.size.width/2){
                
                isRight = true
                rightTimestamp = touch.timestamp
                
            }
            
        }
        
        if(!gameOver){
        
            if(isLeft && allowedToShoot){
                
                player1Shoot()
                
            }
            
            if(isRight && allowedToShoot && !isSingleplayer){
                
                player2Shoot()
                
            }
            
            if(allowedToShoot){
            
                if (leftTimestamp > rightTimestamp){
                    
                    winner = 1
                    
                }else if(rightTimestamp > leftTimestamp){
                    
                    winner = 2

                }else if(rightTimestamp == leftTimestamp){
                    
                    winner = 3
                    
                }else{}
                
                gameOver = true
                
            }

        }else{
            
            
        }
            
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if(isSingleplayer && allowedToShoot && !gameOver){
            
            if(singlePlayerCPUMax > currentWait){
                currentWait += 1
                return
            }
            
            player2Shoot()
            
            if currentTime > leftTimestamp {
                
                winner = 2
                
            }else{
                
                winner = 1
                
            }
            
            gameOver = true
            
            allowedToShoot = false
            
        }
        
        if(winner == 1){
            
            countdownLabel.text = "Player 1 Wins!"
            player2.texture = SKTexture(imageNamed: "rightDead")
            
        }else if(winner == 2){
            
            countdownLabel.text = "Player 2 Wins!"
            player1.texture = SKTexture(imageNamed: "leftDead")
            
        }else if(winner == 3){
            
            countdownLabel.text = "TIE!"
            player1.texture = SKTexture(imageNamed: "leftDead")
            player2.texture = SKTexture(imageNamed: "rightDead")
            
        }
        
        
        if(gameOver){
            
            gameOverDisplay()
            
        }
        
    }
    
    func gameOverDisplay(){
        
        let reset = GameScene(size: self.size)
        reset.scaleMode = self.scaleMode
        
        let animation = SKTransition.fade(withDuration: 7.5)
        self.view?.presentScene(reset, transition: animation)
        
        
    }
    
}
