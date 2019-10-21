//
//  ViewController.swift
//  Concentration
//
//  Created by Samuel Germain on 2019-10-20.
//  Copyright © 2019 Sam G. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var flipCount = 0{
        didSet{
            flipCountLabel.text = "Flip Count: \(flipCount)"
        }
    }
    lazy var game = Concentration(numberOfPairsOfCards: self.cardButtons.count / 2)
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func newGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: cardButtons.count / 2)
        self.updateViewFromModel()
        self.emojiChoices = resetEmojis()
        self.flipCount = 0
    }
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            self.updateViewFromModel()
        }
        
    }
    
    func updateViewFromModel(){
        for index in self.cardButtons.indices{
            let button = cardButtons[index] //Class so its a reference
            let card = game.cards[index]    //copy
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.isEnabled = false
            }else{
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                button.isEnabled = !card.isMatched
            }
        }
    }
    
    lazy var emojiChoices = resetEmojis()
    
    func resetEmojis() -> [String]{
        return ["👻", "🎃", "🦕", "🦑", "🐳", "🐙"]
    }
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String{
        print(card.identifier)
        if emoji[card.identifier] == nil, emojiChoices.count > 0{
            let randIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

