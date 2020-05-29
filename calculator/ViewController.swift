//
//  ViewController.swift
//  calculator
//
//  Created by Femi Abolaji on 23/05/2020.
//  Copyright © 2020 Femi Abolaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // buttons
    @IBOutlet weak var resultScreen: UILabel!
    var tempValue: String = "0"
    var listOfValues: [String] = []
    var op: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        render(tempValue)
    }
    
    private func render(_ value: String) -> Void {
        let parts = value.components(separatedBy: ".")
        
        resultScreen.text = parts.count > 1 && parts[1] == "0"
            ? parts[0]
            : value
    }
    
    private func isScreenValueZero() -> Bool {
        return tempValue == "0"
    }
    
    private func inputValue(value: String, override: Bool = false) -> Void {
        if !override {
            tempValue = isScreenValueZero() ? "\(value)" : "\(tempValue)\(value)"
            render(tempValue)
            return
        }
        render(value)
    }
    
    private func evaluateExpression(first: Double, second: Double, opSymbol: String) -> Double {
        var result: Double = 0
        
        switch opSymbol {
            case "+":
                result = first + second
            case "-":
                result = first - second
            case "*":
                result = first * second
            case "/":
                result = first / second
            default:
                break
        }

        return result
    }
    
    @IBAction func resetButtonClick(_ sender: UIButton) {
        tempValue = "0"
        op = ""
        listOfValues = []
        render(tempValue)
    }
    
    @IBAction func operatorButtonClick(_ sender: UIButton) {
        listOfValues.append(tempValue)

        if listOfValues.count == 2 {
            let a = Double(listOfValues.remove(at: 0))!
            let b = Double(listOfValues.remove(at: 0))!
            
            let result = String(evaluateExpression(first: a, second: b, opSymbol: op))
            listOfValues.insert(result, at: 0)
            inputValue(value: result, override: true)
        }

        tempValue = "0"
        op = sender.titleLabel?.text ?? ""
    }
    
    @IBAction func onInputEntry(_ sender: UIButton) {
        let value = sender.titleLabel?.text ?? ""
        let isDecimalPresent = tempValue.firstIndex(of: ".") != nil
        
        if value == "." && isDecimalPresent {
            return
        }

        inputValue(value: value)
    }
    
}

