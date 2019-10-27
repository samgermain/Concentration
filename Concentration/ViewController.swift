//
//  ViewController.swift
//  Concentration
//
//  Created by Samuel Germain on 2019-10-20.
//  Copyright © 2019 Sam G. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var flipCountObs: NSKeyValueObservation?
    private var scoreObs: NSKeyValueObservation?
    
    
    @objc lazy var game = Concentration(numberOfPairsOfCards: self.cardButtons.count / 2)
    
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
            self.updateFlipCountLabel()
        }
    }
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!

    override func viewWillAppear(_ animated: Bool) {
        self.setObservation()
    }
    
    func setObservation(){
        self.flipCountObs = self.observe(\.game.flipCount) { _, _ in
            self.updateFlipCountLabel()
        }
        self.scoreObs = self.observe(\.game.score)  { _, _ in
            self.scoreLabel.text = "Score: \(self.game.score)"
        }
    }

    func updateFlipCountLabel(){
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flip Count:  \(self.game.flipCount)", attributes: attributes)
        self.flipCountLabel.attributedText = attributedString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViewFromTheme()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.flipCountObs = nil
    }

    @IBAction private func newGame(_ sender: UIButton) {
        self.resetModel()
        self.updateViewFromModel()
    }
    
    private func resetModel(){
        game.prepareForNewGame()
        self.flipCountObs = nil
        self.scoreObs = nil
        game = Concentration(numberOfPairsOfCards: cardButtons.count / 2, theme: game.theme)
        self.setObservation()
        self.resetEmojis()
        
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            self.updateViewFromModel()
        }
        
    }
    
    private func updateViewFromModel(){
        for index in self.cardButtons.indices{
            let button = cardButtons[index] //Class so its a reference
            let card = game.cards[index]    //copy
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.isEnabled = false
            }else{
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : game.theme.cardColor
                button.isEnabled = !card.isMatched
            }
        }
    }
    
    private lazy var emojiChoices = game.theme.emojiChoices
    
    private func resetEmojis(){
        self.emojiChoices = game.theme.emojiChoices
        emoji = [Card:String]()
    }
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String{
        if emoji[card] == nil, emojiChoices.count > 0{
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
    
    @IBAction func changeTheme(_ sender: UIButton) {
        
        game.theme = Theme(theme: sender.titleLabel!.text!)
        self.updateViewFromTheme()
    }
    
    private func updateViewFromTheme(){
        self.resetEmojis()
        self.view.backgroundColor = game.theme.backGroundColor
        for button in self.cardButtons{
            if !buttonIsFaceUpOrMatched(button){
                button.backgroundColor = game.theme.cardColor
            }
        }
    }
    
    private func buttonIsFaceUpOrMatched(_ button: UIButton) -> Bool{
        if let cardIndex = cardButtons.firstIndex(of: button){
            return game.cards[cardIndex].isFaceUp || game.cards[cardIndex].isMatched
        }else{
            return false
        }
    }
    
}

