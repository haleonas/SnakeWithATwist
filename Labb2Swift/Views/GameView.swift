//
//  GameView.swift
//  Labb2Swift
//
//  Created by Jesper Stenlund on 2020-02-25.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

import SwiftUI
import SpriteKit

struct GameView:  UIViewRepresentable{
    
    //@Environment(\.managedObjectContext) var managedObjectContext
    
    func makeUIView(context:Context) -> SKView {
        let displaySize = UIScreen.main.bounds
        
        let frame = CGRect(x: 0, y: 0, width: displaySize.width, height: displaySize.height - 100)
        return SKView(frame: frame)
    }

    func updateUIView(_ uiView: SKView, context: Context) {
        let scene = GameScene(size: uiView.bounds.size)
        uiView.showsFPS = true
        uiView.showsNodeCount = true
        uiView.ignoresSiblingOrder = true
        
        scene.scaleMode = .resizeFill
        
        uiView.presentScene(scene)
    }
}



