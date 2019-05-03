//
//  level.swift
//  Emojiwar
//
//  Created by Kamil Dlutowski on 30/03/2019.
//  Copyright © 2019 Kamil Dlutowski. All rights reserved.
//

import Foundation

let numColumns = 9
let numRows = 9

class Level {
    private var emojis = Array2D<Emoji>(columns: numColumns, rows: numRows)
    private var tiles = Array2D<Tile>(columns: numColumns, rows: numRows)
    
    init(filename: String) {
        // 1
        guard let levelData = LevelData.loadFrom(file: filename) else { return }
        // 2
        let tilesArray = levelData.tiles
        // 3
        for (row, rowArray) in tilesArray.enumerated() {
            // 4
            let tileRow = numRows - row - 1
            // 5
            for (column, value) in rowArray.enumerated() {
                if value == 1 {
                    tiles[column, tileRow] = Tile()
                }
            }
        }
    }
    
    func emoji(atColumn column: Int, row: Int) -> Emoji? {
        precondition(column >= 0 && column < numColumns)
        precondition(row >= 0 && row < numRows)
        return emojis[column, row]
    }
    
    func tileAt(column: Int, row: Int) -> Tile? {
        precondition(column >= 0 && column < numColumns)
        precondition(row >= 0 && row < numRows)
        return tiles[column, row]
    }
    
    func shuffle() -> Set<Emoji> {
        return createInitialEmojis()
    }
    
    private func createInitialEmojis() -> Set<Emoji> {
        var set: Set<Emoji> = []
        
        // 1
        for row in 0..<numRows {
            for column in 0..<numColumns {
                
                // 2
                if tiles[column, row] != nil {
                    let emojiTypex = EmojiType.random()
                    
                    // 3
                    let emojix = Emoji(column: column, row: row, emojiType: emojiTypex)
                    emojis[column, row] = emojix
                    
                    // 4
                    set.insert(emojix)
                }
            }
        }
        return set
    }
}
