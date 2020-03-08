//
//  GameOverView.swift
//  Labb2Swift
//
//  Created by Jesper Stenlund on 2020-03-02.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

import SwiftUI
import SpriteKit

struct GameOverView_Previews: UIViewRepresentable{
   
    func updateUIView(_ uiView: SKView, context: UIViewRepresentableContext<GameOverView_Previews>) {
        let displaySize = UIScreen.main.bounds
        
        let scene = GameOver(size: CGSize(width: displaySize.width, height: displaySize.height))
        uiView.showsFPS = false
        uiView.showsNodeCount = false
        uiView.presentScene(scene)
    }
    
    func makeUIView(context:Context) -> SKView {
        let displaySize = UIScreen.main.bounds
        
        let frame = CGRect(x: 0, y: 0, width: displaySize.width, height: displaySize.height)
        return SKView(frame: frame)
    }
}
