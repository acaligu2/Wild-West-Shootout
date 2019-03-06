//
//  MainMenu.swift
//  Wild West Shootout
//
//  Created by Anthony on 3/6/19.
//  Copyright © 2019 Anthony Caligure. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene{
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.setScale(0.1)
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        
        self.addChild(background)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            if touch == touches.first{
                
                print("Transitioning")
                
            }
            
        }
        
    }
    
}
