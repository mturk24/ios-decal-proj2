//
//  GuessField.swift
//  Hangman
//
//  Created by Matthew Turk on 11/11/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import Foundation
import UIKit

class GuessField: UITextField, UITextFieldDelegate {
    
    var guessCap: Int?
    
    @IBInspectable var lengthLimit: Int {
        get {
            guard let length = guessCap else {
                return Int.max
            }
            return length
        }
        set {
            guessCap = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        guard string.characters.count > 0 else {
            return true
        }
        
        
        let currentText = textField.text ?? ""
        
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        return prospectiveText.characters.count <= lengthLimit
    }
    
}


