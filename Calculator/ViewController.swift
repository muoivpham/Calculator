//
//  ViewController.swift
//  Calculator
//
//  Created by muoivpham on 12/16/16.
//  Copyright © 2016 muoivpham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    private var userIsInTheMiddleOfTyping = false

    @IBOutlet private weak var display: UILabel!
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    
        private var displayValue: Double{
        get {
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(symbol: mathematicalSymbol)
        }
        
        displayValue = brain.result
    }
    
    
   
}
