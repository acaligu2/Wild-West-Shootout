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
    
    let gunSound = SKAction.playSoundFileNamed("gunshot.wav", waitForCompletion: false)
    let threeSound = SKAction.playSoundFileNamed("three.wav", waitForCompletion: true)
    let twoSound = SKAction.playSoundFileNamed("two.wav", waitForCompletion: true)
    let oneSound = SKAction.playSoundFileNamed("one.wav", waitForCompletion: true)
    
    var allowedToShoot = false
    var gameOver = false
    var winner = -1
    
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
    
    override func didMove(to view: SKView) {
        
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
        
        player2.setScale(1.25)
        player2.position = CGPoint(x: self.size.width * 0.85, y: self.size.height * 0.30)
        player2.zPosition = 2
        
        self.addChild(player2)
        
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
        
        
        
    }
    
    func startCount(){
        labelText = maxTime
        
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
            
            countdownLabel.text = "\(labelText)"
            
        
        }
        
    }
 
    
    func player1Shoot(){
        
        bullet1.setScale(5)
        
        bullet1.position = player1.position
        bullet1.zPosition = 1
        self.addChild(bullet1)
        
        let moveBullet = SKAction.move(to: player2.position, duration: 0.1)
        let deleteBullet = SKAction.removeFromParent()
        
        player1.texture = SKTexture(imageNamed:"leftCowboy2")
        let bulletSequence = SKAction.sequence([gunSound, moveBullet, deleteBullet])
     
        bullet1.run(bulletSequence)
        
    }
    
    func player2Shoot(){
        
        bullet2.setScale(5)
        
        bullet2.position = player2.position
        bullet2.zPosition = 1
        self.addChild(bullet2)
        
        let moveBullet = SKAction.move(to: player1.position, duration: 0.1)
        let deleteBullet = SKAction.removeFromParent()
        
        player2.texture = SKTexture(imageNamed:"pixil-frame-0")
        let bulletSequence = SKAction.sequence([gunSound, moveBullet, deleteBullet])
        
        bullet2.run(bulletSequence)
        
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var isRight : Bool = false
        var isLeft : Bool = false
        
        var leftTimestamp = 0.0
        var rightTimestamp = 0.0
        
        for touch in touches{
            
            if(touch == touches.first){
                
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
            
            if(isRight && allowedToShoot){
                
                player2Shoot()
                
            }
            
            if(allowedToShoot){
            
                if (leftTimestamp > rightTimestamp){
                    
                    countdownLabel.text = "Player 1 Wins!"
                    player2.texture = SKTexture(imageNamed: "rightDead")
                    
                }else if(rightTimestamp > leftTimestamp){
                    
                    countdownLabel.text = "Player 2 Wins!"
                    player1.texture = SKTexture(imageNamed: "leftDead")

                }else if(rightTimestamp == leftTimestamp){
                    
                    countdownLabel.text = "TIE!"
                    player1.texture = SKTexture(imageNamed: "leftDead")
                    player2.texture = SKTexture(imageNamed: "rightDead")
                    
                }else{}
                
                gameOver = true
                
            }

        }else{
            
            
        }
            
    }
    
}
