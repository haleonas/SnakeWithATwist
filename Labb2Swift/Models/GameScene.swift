//
//  GameScene.swift
//  Labb2Swift
//
//  Created by Jesper Stenlund on 2020-02-26.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

import SpriteKit
import SwiftUI
import Foundation
import CoreData

final class GameScene: SKScene {
    
    let player = SKSpriteNode(imageNamed: "Snakehead")
    let apple = SKSpriteNode(imageNamed: "Apple")
    var snake = Snake()
    var activeBlocks = [SKSpriteNode]()
    
    @State private var newScore = 0 
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        //adds swipe functionality
        let swipeRight : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
        let swipeLeft  : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        let swipeUp    : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
        let swipeDown  : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown))


        //which direction the swipe is going
        swipeRight  .direction = .right
        swipeLeft   .direction = .left
        swipeUp     .direction = .up
        swipeDown   .direction = .down

        //adds the swipes to the view
        view.addGestureRecognizer(swipeRight)
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeDown)
        view.addGestureRecognizer(swipeUp)
        
        print("Scene didmove:")
    }
    
    //if the scene got loaded add the player to the game and start it.
    override func sceneDidLoad() {
        
        //sets players starting position
        print(frame)
        player.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        addChild(player)
        
        //put in the first apple in the game
        moveApple()
        
        //setups a function to be run every 5seconds, in line with how long the blocks are up
        run(SKAction.repeatForever(
          SKAction.sequence([
            SKAction.run(addBlock),
            SKAction.wait(forDuration: 5.0)
          ])
        ))
    }
    
    //movement logic
    @objc func swipedRight(sender: UISwipeGestureRecognizer) {
        if(self.snake.currentDirection != "left"){
            self.snake.currentDirection = "right"
            print("right")
        }
    }
    @objc func swipedLeft(sender: UISwipeGestureRecognizer) {
        if(self.snake.currentDirection != "right"){
            self.snake.currentDirection = "left"
            print("left")
        }
    }
    @objc func swipedDown(sender: UISwipeGestureRecognizer) {
        
        if(self.snake.currentDirection != "up"){
            self.snake.currentDirection = "down"
            print("down")
        }
        
    }
    @objc func swipedUp(sender: UISwipeGestureRecognizer) {
        if(self.snake.currentDirection != "down"){
            self.snake.currentDirection = "up"
            print("up")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        //moving according the snake towards its current direction
        if(snake.currentDirection == "right"){
            player.position.x = player.position.x + CGFloat(snake.speed)
        } else if(snake.currentDirection == "left"){
            player.position.x = player.position.x - CGFloat(snake.speed)
        } else if(snake.currentDirection == "up") {
            player.position.y = player.position.y + CGFloat(snake.speed)
        } else { //down
            player.position.y = player.position.y - CGFloat(snake.speed)
        }
        
        //check if player is out of bounds
        if(player.position.y + player.size.height > frame.height || player.position.y < 0)
        {
            print("out of bounds")
            self.gameOver(eatenApples: Int(self.snake.eatenApples))
        }
        if(player.position.x + player.size.width > frame.width || player.position.x < 0)
        {
            print("out of bounds")
            self.gameOver(eatenApples: Int(self.snake.eatenApples))
        }
        
        //check if player hit apple
        if(apple.intersects(player)){
            print("nom nom nom")
            self.snakeHitApple()
        }
        
        //check if player hit a block
        for block in activeBlocks
        {
            if(block.intersects(player))
            {
                self.gameOver(eatenApples: Int(self.snake.eatenApples))
                print("ouch ouch ouch")
            }
        }
    }
    
    
    func moveApple() {
        //gives the apple a random position in the frame
        var appleX = arc4random_uniform(UInt32(frame.width))
        var appleY = arc4random_uniform(UInt32(frame.height))
        
        //checks if part of the apple is outside  of the frame
        if(CGFloat(appleY) + apple.size.height > frame.height){
            appleY = UInt32(CGFloat(appleY) - apple.size.height)
        } else if(CGFloat(appleX) + apple.size.width > frame.width) {
            appleX = UInt32(CGFloat(appleX) - apple.size.width)
        }
        
        apple.position = CGPoint(x: Double(appleX), y: Double(appleY))
        addChild(apple)
    }
    
    //if player have eaten an apple
    func snakeHitApple(){
        apple.removeFromParent()
        snake.eatenApples = snake.eatenApples + 1
        snake.speed = snake.speed + (snake.eatenApples/30)
        self.moveApple()
    }
    
    func addBlock()
    {
        //cleans the array of blocks
        activeBlocks = [SKSpriteNode]()
        
        let blockSizes = ["small","medium","large"]
        let numOfBlocks = arc4random_uniform(10) + 3
        
        for _ in 0..<numOfBlocks
        {
            let block = SKSpriteNode(imageNamed: blockSizes.randomElement() ?? "small")
           
            //changes the position of the block if it is intersecting the player or the apple
            repeat {
                let posY = arc4random_uniform(UInt32(frame.height - block.size.height))
                let posX = arc4random_uniform(UInt32(frame.width - block.size.width))
                block.position = CGPoint(x: CGFloat(posX), y: CGFloat(posY))
            } while block.intersects(player) || block.intersects(apple)
            
            addChild(block)
            activeBlocks.append(block)
            
            //how long the block is in the field in seconds
            let duration = 5
            
            //how the block should move during its time on the field
            let action = SKAction.move(to:CGPoint(x: block.position.x,y:block.position.y),
            duration: TimeInterval(duration))
            
            //what the block should do at the end of its time
            let actionMoveDone = SKAction.removeFromParent()
            
            block.run(SKAction.sequence([action,actionMoveDone]))
        }
    }
    func gameOver(eatenApples:Int){
        scene?.removeFromParent()
        
        //creating a new scene object to be shown
        let newScene = GameOver(size: self.size)
        newScene.eatenApples = Int(self.snake.eatenApples)
        newScene.addlabel()
        
        /*
        //saves the score via userdefaults
        let saveScore = SaveRetrieveScores()
        saveScore.saveScore(score: Int(snake.eatenApples))
        */
        
        //creates context for a coredata object
        //has to be created locally to work in 11.13.1
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let _ = GameView().environment(\.managedObjectContext,context)
        
        //makes a object to be added to the database
        let scoreboard = Scoreboard(context: context)
        
        //gets the current time and date for the scoreboard object
        let currentDate = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yy HH:mm"
        let stringDate = dateFormat.string(from: currentDate)

        scoreboard.createdAt = stringDate
        scoreboard.score = Int(self.snake.eatenApples)
        
        do{
            try context.save()
        } catch let err {
            print(err.localizedDescription)
        }
        self.view?.presentScene(newScene)
    }
}
