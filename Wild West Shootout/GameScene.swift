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
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.setScale(0.1)
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        
        self.addChild(background)
        
        let player1 = SKSpriteNode(imageNamed:"leftCowboy1")
        player1.setScale(1.25)
        player1.position = CGPoint(x: self.size.width * 0.15, y: self.size.height * 0.30)
        player1.zPosition = 2
        
        self.addChild(player1)
        
        let player2 = SKSpriteNode(imageNamed:"rightCowboy0")
        player2.setScale(1.25)
        player2.position = CGPoint(x: self.size.width * 0.85, y: self.size.height * 0.30)
        player2.zPosition = 2
        
        self.addChild(player2)
        
    }
    
}
