//
//  MainMenuContent.swift
//  Labb2Swift
//
//  Created by Jesper Stenlund on 2020-02-25.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

import SwiftUI
import SpriteKit

struct MainMenuPresenterText: View {
    var body: some View {
        Text("Main menu")
    }
}

struct MainMenuButtons: View {
    var body: some View {
        NavigationView {
            VStack {

                MainMenuPresenterText()
                    .padding(20)
                    .font(.system(size: 40))

                Spacer(minLength: 30)
                NavigationLink(destination: GameView()){
                    Text("Play game")
                    .font(.system(size: 20))
                }
                .padding(50)
            
                NavigationLink(destination: ScoreboardView()) {
                    Text("Scoreboard")
                    .font(.system(size: 20))
                }
                Spacer()
            }
        }
    }
}

/*NavigationView
{
    NavigationLink(destination: gameView()) {
        Text("Do Something")
    }
}*/
