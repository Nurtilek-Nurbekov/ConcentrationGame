//
//  ViewController.swift
//  ConcentrationGameFullVersion
//
//  Created by Nurtilek on 11/8/20.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = ConcentrationGame(numberOfPairsOfCards: (buttonCollection.count + 1) / 2)
    
    var emojiCollection = ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🍈","🍒","🍑"]
        
    var emojiDictionary = [Int:String]()
    
    func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiCollection.count)))
            emojiDictionary[card.identifier] = emojiCollection.remove(at: randomIndex)
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
    func updateViewFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
            }
        }
    }
    
    @IBOutlet var buttonCollection: [UIButton]!
    @IBAction func buttonAction (_ sender: UIButton) {
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
    }

}

