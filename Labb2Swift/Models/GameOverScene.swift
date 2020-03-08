//
//  GameOverScene.swift
//  Labb2Swift
//
//  Created by Jesper Stenlund on 2020-03-02.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

import Foundation
import SpriteKit

class GameOver: SKScene{
    
    var eatenApples: Int = 0

    override init(size:CGSize){
        super.init(size:size)
        
        scene?.backgroundColor = UIColor.white

    }
    
    func addlabel()
    {
        let message = eatenApples == 1 ? "You ate \(eatenApples) apple" : "You ate \(eatenApples) apples"
        
        let scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: size.width/2, y: size.height/2)
        scoreLabel.text = message
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = SKColor.black
        
        print(eatenApples)
        
        addChild(scoreLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
