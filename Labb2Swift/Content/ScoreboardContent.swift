//
//  ScoreboardContent.swift
//  Labb2Swift
//
//  Created by Jesper Stenlund on 2020-02-25.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

import SwiftUI

struct ScoreboardText: View {
    
    @FetchRequest(fetchRequest: Scoreboard.fetchData()) var scoreBoardItems:FetchedResults<Scoreboard>
    
    var body: some View {
        NavigationView{
            List{
                if(self.scoreBoardItems.count != 0){
                    ForEach(self.scoreBoardItems){scoreboard in
                        VStack{
                            Text("Score: \(scoreboard.score)")
                            Text("Date: \(scoreboard.createdAt)")
                        }
                    }
                } else {
                        Text("Empty")
                }
            }
            .navigationBarTitle(Text("Scoreboard"))
        }
    }
}

