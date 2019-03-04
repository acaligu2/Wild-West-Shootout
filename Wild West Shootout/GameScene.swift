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
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.setScale(0.1)
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        
        self.addChild(background)
        
        player1.setScale(1.25)
        player1.position = CGPoint(x: self.size.width * 0.15, y: self.size.height * 0.30)
        player1.zPosition = 2
        
        self.addChild(player1)
        
        player2.setScale(1.25)
        player2.position = CGPoint(x: self.size.width * 0.85, y: self.size.height * 0.30)
        player2.zPosition = 2
        
        self.addChild(player2)
        
    }
    
    func player1Shoot(){
        
        let bullet1 = SKSpriteNode(imageNamed: "bullet")
        bullet1.setScale(5)
        
        bullet1.position = player1.position
        bullet1.zPosition = 1
        self.addChild(bullet1)
        
        let moveBullet = SKAction.moveTo(x: self.size.width + bullet1.size.width, duration: 0.5)
        let deleteBullet = SKAction.removeFromParent()
        
        player1.texture = SKTexture(imageNamed:"leftCowboy2")
        let bulletSequence = SKAction.sequence([moveBullet, deleteBullet])
     
        bullet1.run(bulletSequence)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        player1Shoot()
        
    }
    
}
