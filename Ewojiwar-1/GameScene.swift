//
//  GameScene.swift
//  Emojiwar
//
//  Created by Kamil Dlutowski on 30/03/2019.
//  Copyright © 2019 Kamil Dlutowski. All rights reserved.
//
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var swipeFromcolumn:Int?
    private var swipeFromrow:Int?
    
    
    var level: Level!
//    let tilesLayer = SKNode()
    let cropLayer = SKCropNode()
//    let maskLayer = SKNode()
    
    let tileWidth: CGFloat = 35.0
    let tileHeight: CGFloat = 40.0
    
    let gameLayer = SKNode()
    let emojiLayer = SKNode()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let background = SKSpriteNode(imageNamed: "Background")
        background.size = size
        addChild(background)
        addChild(gameLayer)
        
        let layerPosition = CGPoint(
            x: -tileWidth * CGFloat(numColumns) / 2,
            y: -tileHeight * CGFloat(numRows) / 2)
//        tilesLayer.position = layerPosition
//
//        tilesLayer.position = layerPosition
//        maskLayer.position = layerPosition
//        cropLayer.maskNode = maskLayer
//        gameLayer.addChild(tilesLayer)
        gameLayer.addChild(cropLayer)
        
        
        emojiLayer.position = layerPosition
        cropLayer.addChild(emojiLayer)
        
    }
    
    func addSprites(for emojis: Set<Emoji>) {
        for emoji in emojis {
            let sprite = SKSpriteNode(imageNamed: emoji.emojiType.spriteName)
            sprite.size = CGSize(width: tileWidth, height: tileHeight)
            sprite.position = pointFor(column: emoji.column, row: emoji.row)
            emojiLayer.addChild(sprite)
            emoji.sprite = sprite
        }
    }
    
//    func addTiles() {
//        // 1
//        for row in 0..<numRows {
//            for column in 0..<numColumns {
//                if level.tileAt(column: column, row: row) != nil {
//                    let tileNode = SKSpriteNode(imageNamed: "MaskTitle")
//                    tileNode.size = CGSize(width: tileWidth, height: tileHeight)
//                    tileNode.position = pointFor(column: column, row: row)
//                    maskLayer.addChild(tileNode)
//                }
//            }
//        }
//        
//        // 2
//        for row in 0...numRows {
//            for column in 0...numColumns {
//                let topLeft     = (column > 0) && (row < numRows)
//                    && level.tileAt(column: column - 1, row: row) != nil
//                let bottomLeft  = (column > 0) && (row > 0)
//                    && level.tileAt(column: column - 1, row: row - 1) != nil
//                let topRight    = (column < numColumns) && (row < numRows)
//                    && level.tileAt(column: column, row: row) != nil
//                let bottomRight = (column < numColumns) && (row > 0)
//                    && level.tileAt(column: column, row: row - 1) != nil
//                
//                var value = topLeft.hashValue
//                value = value | topRight.hashValue << 1
//                value = value | bottomLeft.hashValue << 2
//                value = value | bottomRight.hashValue << 3
//                
//                // Values 0 (no tiles), 6 and 9 (two opposite tiles) are not drawn.
//                if value != 0 && value != 6 && value != 9 {
//                    let name = String(format: "Tile_%ld", value)
//                    let tileNode = SKSpriteNode(imageNamed: name)
//                    tileNode.size = CGSize(width: tileWidth, height: tileHeight)
//                    var point = pointFor(column: column, row: row)
//                    point.x -= tileWidth / 2
//                    point.y -= tileHeight / 2
//                    tileNode.position = point
//                    tilesLayer.addChild(tileNode)
//                }
//            }
//        }
//    }
    
    private func pointFor(column: Int, row: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat(column) * tileWidth + tileWidth / 2,
            y: CGFloat(row) * tileHeight + tileHeight / 2)
    }
    
    private func convertPoint(_ point: CGPoint) -> (success: Bool, column: Int, row: Int)
    {
        if point.x >= 0 && point.x < CGFloat(numColumns) * tileWidth &&
            point.y >= 0 && point.y < CGFloat(numRows) * tileHeight
        {
            return (true, Int(point.x / tileWidth), Int(point.y / tileHeight))
        } else
        {
            return (false, 0, 0)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard let touch = touches.first
        else
        {
            return
        }
    let location = touch.location(in: emojiLayer)
        
    let (success,column,row)=convertPoint(location)
        if success
        {
            if let emoji = level.emoji(atColumn: column, row: row) {
            swipeFromrow=row
            swipeFromcolumn=column
        }
    }
        
    
    
    
}


}
