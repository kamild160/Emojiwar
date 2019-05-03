//
//  emoji.swift
//  Emojiwar
//
//  Created by Kamil Dlutowski on 30/03/2019.
//  Copyright © 2019 Kamil Dlutowski. All rights reserved.
//

import SpriteKit

// MARK: - CookieType
enum EmojiType: Int {

    case unknown = 0, sad, cry, angry, hapy, wink, grin
    
    var spriteName: String {
        let spriteNames = [
            "sad",
            "cry",
            "angry",
            "hapy",
            "wink",
            "grin"]
        
        return spriteNames[rawValue - 1]
    }
    
    static func random() -> EmojiType {
        return EmojiType(rawValue: Int(arc4random_uniform(6)) + 1)!
    }
}

// MARK: - Cookie
class Emoji: CustomStringConvertible, Hashable {
    
    var hashValue: Int {
        return row * 10 + column
    }
    
    static func ==(lhs: Emoji, rhs: Emoji) -> Bool {
        return lhs.column == rhs.column && lhs.row == rhs.row
        
    }
    
    var description: String {
        return "type:\(emojiType) square:(\(column),\(row))"
    }
    
    var column: Int
    var row: Int
    let emojiType: EmojiType
    var sprite: SKSpriteNode?
    
    init(column: Int, row: Int, emojiType: EmojiType) {
        self.column = column
        self.row = row
        self.emojiType = emojiType
    }
}
