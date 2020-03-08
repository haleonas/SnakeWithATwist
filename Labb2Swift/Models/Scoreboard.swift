//
//  Scoreboard.swift
//  Labb2Swift
//
//  Created by Jesper Stenlund on 2020-03-02.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

import Foundation
import CoreData

public class Scoreboard: NSManagedObject,Identifiable{
    @NSManaged public var createdAt:String
    @NSManaged public var score:Int
}

extension Scoreboard{
    static func fetchData() -> NSFetchRequest<Scoreboard>{
        let request:NSFetchRequest<Scoreboard> = Scoreboard.fetchRequest() as! NSFetchRequest<Scoreboard>
        
        let sortDescriptor = NSSortDescriptor(key: "score",ascending:false)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
