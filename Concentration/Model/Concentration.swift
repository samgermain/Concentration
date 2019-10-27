//
//  Concentration.swift
//  Concentration
//
//  Created by Samuel Germain on 2019-10-20.
//  Copyright © 2019 Sam G. All rights reserved.
//

import Foundation

class Concentration: NSObject{
    private(set) var cards = [Card]()
    private var indexOfFaceUpCard: Int? {
        get{
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    public var theme = Theme(theme: "Birds")
    @objc dynamic var flipCount = 0
    @objc dynamic var score = 0
    
    
    func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): Chosen index not in cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfFaceUpCard, matchIndex != index{
                if cards[index] == cards[matchIndex]{
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    score += 2
                }else{
                    if cards[index].hasBeenSeen{
                        score -= 1
                    }
                    if cards[matchIndex].hasBeenSeen{
                        score -= 1
                    }
                }
                cards[index].isFaceUp = true
                cards[index].hasBeenSeen = true
                cards[matchIndex].hasBeenSeen = true
            }else{
                indexOfFaceUpCard = index
            }
        }
        flipCount += 1
    }
    
    convenience init(numberOfPairsOfCards: Int, theme: Theme){
        self.init(numberOfPairsOfCards: numberOfPairsOfCards)
        self.theme = theme
    }
    
    
    
    init(numberOfPairsOfCards: Int){
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        cards = cards.shuffled()
    }
    
    func prepareForNewGame(){
        score = 0
        flipCount = 0
    }
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
