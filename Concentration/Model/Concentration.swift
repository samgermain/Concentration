//
//  Concentration.swift
//  Concentration
//
//  Created by Samuel Germain on 2019-10-20.
//  Copyright © 2019 Sam G. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var indexOfFaceUpCard: Int?
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched{
            if let matchIndex = indexOfFaceUpCard, matchIndex != index{
                if cards[index].identifier == cards[matchIndex].identifier{
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                indexOfFaceUpCard = nil
                cards[index].isFaceUp = true
            }else{
                for flipIndex in cards.indices{
                    cards[flipIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        cards = cards.shuffled()
    }
    
}
