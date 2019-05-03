//
//  GameViewController.swift
//  Emojiwar
//
//  Created by Kamil Dlutowski on 30/03/2019.
//  Copyright © 2019 Kamil Dlutowski. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class GameViewController: UIViewController {
    
    // MARK: Properties
    
    // The scene draws the tiles and cookie sprites, and handles swipes.
    var scene: GameScene!
    var level: Level!
    
    var movesLeft = 0
    var score = 0
    
   
    
    // MARK: IBOutlets
    @IBOutlet weak var gameOverPanel: UIImageView!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var shuffleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        // Create and configure the scene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        level = Level(filename: "Level_0")
        scene.level = level
        
        // Present the scene.
        skView.presentScene(scene)
        //scene.addTiles()
        beginGame()
    }
    
    // MARK: IBActions
    @IBAction func shuffleButtonPressed(_: AnyObject) {
        
    }
    
    // MARK: View Controller Functions
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    func beginGame() {
        shuffle()
    }
    
    func shuffle() {
        let newemoji = level.shuffle()
        scene.addSprites(for: newemoji)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }
    
}
