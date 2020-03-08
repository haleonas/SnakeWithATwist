//
//  SaveRetrieveScore.swift
//  Labb2Swift
//
//  Created by Jesper Stenlund on 2020-03-02.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

import Foundation

struct SaveRetrieveScores{
    
    let key = "SCORE"
    
    func saveScore(score:Int){
        let save: UserDefaults = UserDefaults.standard
        
        var tempList = retrieveScore()
        tempList.append(score)
        tempList = tempList.sorted{$0>$1}
        
        save.set(tempList,forKey: key)
        
    }
    func retrieveScore() -> [Int]{
        let retrieve = UserDefaults.standard
        
        let tempList = retrieve.object(forKey: key) as? [Int] ?? [Int]()
        print(tempList)
        return tempList
    }
}
