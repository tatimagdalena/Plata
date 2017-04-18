//
//  ConfigViewController.swift
//  PlataDemo
//
//  Created by Tatiana Magdalena on 07/03/17.
//  Copyright © 2017 Stone. All rights reserved.
//

import UIKit
import Plata


enum SegmentedControl: Int {
    case value = 0, symbol/*, decimal, grouping*/
}

enum ValueSegment: Int {
    case digits = 0, cents, none
}

enum SymbolSegment: Int {
    case code = 0, symbol, locale
}

//enum DecimalSeparatorSegment: Int {
//    case comma = 0, period
//}
//
//enum GroupingSeparatorSegment: Int {
//    case comma = 0, period
//}


class ConfigViewController: UITableViewController {

    //Storyboard connections
    
    //
    @IBOutlet var valueField: PlataField!
    
    @IBOutlet var formattedStringLabel: UILabel!
    @IBOutlet var centsLabel: UILabel!
    @IBOutlet var realValueLabel: UILabel!
    
    
    @IBOutlet var valueSegmentedControl: UISegmentedControl!
    @IBOutlet var valueLimitField: UITextField!
    @IBOutlet var symbolSegmentedControl: UISegmentedControl!
    @IBOutlet var symbolField: UITextField!
    @IBOutlet var decimalSeparatorField: UITextField!
    @IBOutlet var groupingSeparatorField: UITextField!
    
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.bounces = false
        
        addToolBar(textField: valueField)
        addToolBar(textField: valueLimitField)
        addToolBar(textField: symbolField)
        addToolBar(textField: decimalSeparatorField)
        addToolBar(textField: groupingSeparatorField)
        
        valueSegmentedControl.tag = SegmentedControl.value.rawValue
        symbolSegmentedControl.tag = SegmentedControl.symbol.rawValue
        
        
        clearContent()
        
        if let limitValue = valueField.valueLimitType.limitValue {
            valueLimitField.text = String(limitValue)
        }
        else {
            valueLimitField.text = "-"
        }
        
        symbolField.text = valueField.plata.currencySymbol.codeString 
        decimalSeparatorField.text = valueField.plata.decimalSeparator
        groupingSeparatorField.text = valueField.plata.groupingSeparator
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Buttons actions
    
    
    @IBAction func updateValues(_ sender: Any) {
        
        let centsValue: Int = valueField.plata.integer
        let realValue: Double = valueField.plata.realValue
        
        self.formattedStringLabel.text = valueField.plata.formattedString
        self.centsLabel.text = String(centsValue) // same result achieved with valueField.plata.onlyNumbers()
        self.realValueLabel.text = String(realValue)
    }
    
    @IBAction func changeValueLimit(_ sender: UIButton) {
        
        let index = ValueSegment(rawValue: valueSegmentedControl.selectedSegmentIndex)
        guard let selected = index else { return }
        
        switch selected {
        case .digits:
            if let digitsString = valueLimitField.text, let digitsValue = Int(digitsString) {
                valueField.valueLimitType = .digits(digitsValue)
            }
            
        case .cents:
            if let centsString = valueLimitField.text, let centsValue = Int(centsString) {
                valueField.valueLimitType = .cents(centsValue)
            }
            
        case .none:
            valueField.valueLimitType = .none
        }
        
        clearContent()
    }
    
    @IBAction func changeCurrencySymbol(_ sender: UIButton) {
        let index = SymbolSegment(rawValue: symbolSegmentedControl.selectedSegmentIndex)
        guard let selected = index else { return }
        
        switch selected {
        case .code:
            if let codeString = symbolField.text {
                valueField.plata.currencySymbol = .code(codeString)
            }
        case .symbol:
            if let symbolString = symbolField.text {
                valueField.plata.currencySymbol = .symbol(symbolString)
            }
        case .locale:
            valueField.plata.currencySymbol = .fromCurrentLocale
        }
    }
    
    
    @IBAction func changeDecimalSeparator(_ sender: UIButton) {
        valueField.plata.decimalSeparator = decimalSeparatorField.text ?? ""
    }
    
    @IBAction func changeGroupingSeparator(_ sender: UIButton) {
        valueField.plata.groupingSeparator = groupingSeparatorField.text ?? ""
    }
    
    
    // MARK: - Config
    
    func clearContent() {
        
        valueField.plata.integer = 0
        formattedStringLabel.text = ""
        centsLabel.text = ""
        realValueLabel.text = ""
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
        let segment = SegmentedControl(rawValue: sender.tag)
        guard let type = segment else { return }
        
        switch type {
        case .value:
            valueHandler()
        case .symbol:
            symbolHandler()
        }
        
    }
    
    func valueHandler() {
        
        let index = ValueSegment(rawValue: valueSegmentedControl.selectedSegmentIndex)
        guard let selected = index else { return }
        
        switch selected {
            
        case .digits:
            valueLimitField.isHidden = false
            if case let .digits(limit)  = valueField.valueLimitType {
                valueLimitField.text = String(limit)
            }
            else {
                valueLimitField.text = ""
            }
            
        case .cents:
            valueLimitField.isHidden = false
            if case let .cents(limit) = valueField.valueLimitType {
                valueLimitField.text = String(limit)
            }
            else {
                valueLimitField.text = ""
            }
            
        case .none:
            valueLimitField.isHidden = true
        }
    }
    
    func symbolHandler() {
        
        
        
        let index = SymbolSegment(rawValue: symbolSegmentedControl.selectedSegmentIndex)
        guard let selected = index else { return }
        
        switch selected {
            
        case .code:
            symbolField.isHidden = false
            symbolField.text = valueField.plata.currencySymbol.codeString ?? ""
            
        case .symbol:
            symbolField.isHidden = false
            symbolField.text = valueField.plata.currencySymbol.symbolString ?? ""
            
        case .locale:
            symbolField.isHidden = true
        }
    }
}
