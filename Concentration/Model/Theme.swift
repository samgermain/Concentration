//
//  theme.swift
//  Concentration
//
//  Created by Samuel Germain on 2019-10-22.
//  Copyright © 2019 Sam G. All rights reserved.
//

import Foundation
import UIKit.UIColor

struct Theme {
    public let emojiChoices: [String]
    public let cardColor: UIColor
    public let backGroundColor: UIColor
    public let descriptor: String
    
    init(theme: String) {
        self.descriptor = theme
        switch theme {
        case "Birds":
            self.emojiChoices = ["🦉", "🐧", "🐥", "🐓", "🦚", "🦜", "🦢", "🕊", "🐔", "🐣", "🦆", "🦅", "🐦", "🐤"]
            self.cardColor = #colorLiteral(red: 1, green: 0.9829703643, blue: 0.08348557068, alpha: 1)
            self.backGroundColor = #colorLiteral(red: 0.8369836614, green: 1, blue: 0.6728702064, alpha: 1)
        case "Reptiles":
            self.emojiChoices = ["🐢", "🐍", "🦕", "🦎", "🐊", "🦖", "🐉", "🐲"]
            self.cardColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            self.backGroundColor = #colorLiteral(red: 0.7568627596, green: 0.5107129609, blue: 0.3638961522, alpha: 1)
        case "Under The Sea":
            self.emojiChoices = ["🦀", "🐡", "🐠", "🦑", "🐬", "🐙", "🐳", "🦐", "🐋", "🐟", ""]
            self.cardColor = #colorLiteral(red: 0.1481565877, green: 0.7109742195, blue: 1, alpha: 1)
            self.backGroundColor = #colorLiteral(red: 0.6888400193, green: 1, blue: 0.9387503711, alpha: 1)
        default:
            print("Error: Invalid Theme")
            self.emojiChoices = [""]
            self.cardColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.backGroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
}
