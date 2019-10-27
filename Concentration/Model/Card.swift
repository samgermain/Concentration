//
//  Card.swift
//  Concentration
//
//  Created by Samuel Germain on 2019-10-20.
//  Copyright © 2019 Sam G. All rights reserved.
//

import Foundation

struct Card: Hashable{
    
    public var isFaceUp = false
    public var isMatched = false
    public var hasBeenSeen = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool{
        return lhs.identifier == rhs.identifier
    }
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
    
    
}
