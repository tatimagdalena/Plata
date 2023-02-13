//
//  CurrencyField.swift
//  Plata
//
//  Created by Tatiana Magdalena on 10/7/16.
//  Copyright © 2016 Tatiana Magdalena. All rights reserved.
//

import UIKit

private var AMOUNT_FIELD_IS_EMPTY: Bool = true

public class PlataField: UITextField {
    
    // MARK: - Properties
    
    public var associatedButton: UIButton?
    
    public var plata: Plata {
        didSet {
            text = plata.numberFormatter.string(from: NSNumber(value: plata.realValue))
            self.placeholder = plata.numberFormatter.string(from: 0.0)
        }
    }
    
    
    //* STYLE *//
    
    //TODO: Allow styling
    //var paddingRight: CGFloat = 20
    //var paddingLeft: CGFloat = 20

    /// How the value on textfield is limited.
    public var valueLimitType: ValueLimit = .digits(10)
    
    
    //* VALUES *//
    
    private var numbers: String {
        let n = string.components(separatedBy: CharacterSet(charactersIn: "0123456789").inverted).joined()
        
        switch valueLimitType {
        case .digits(let dropLastAtDigit):
            if n.characters.count > dropLastAtDigit {
                return String(n.characters.dropLast())
            }
        case .cents(let maxValue):
            if let typedValueInt = Int(n), typedValueInt > maxValue {
                return String(n.characters.dropLast())
            }
        default:
            return n
        }
        return n
    }
    
    
    //TODO: find a way to use Plata values instead of these ones.
    private var integer:    Int    { return Int(numbers) ?? 0 }
    private var percentage: Double { return Double(integer) / 100 }
    private var string:     String { return text ?? "" }
    //
    
    
    // MARK: - Initializers
    
    override public init(frame: CGRect) {
        plata = Plata(cents: 0)
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        plata = Plata(cents: 0)
        super.init(coder: aDecoder)
    }
    
    // If you want to access outlets, you need to do that in -awakeFromNib
    override public func awakeFromNib() {
        
        super.awakeFromNib()
        
        //self.tintColor = UIColor.greenSummary
        //self.font = self.font?.withSize(self.fontSize)
        
        //self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: paddingLeft, height: frame.height))
        //self.leftViewMode = .always
        
        //self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: paddingRight, height: frame.height))
        //self.rightViewMode = .always

        self.addTarget(self, action: #selector(self.textField(_:)), for: .editingChanged)
        
        self.keyboardType = .numberPad
        self.placeholder = plata.numberFormatter.string(from: 0.0)
        self.textAlignment = .center
    }
    
    
    // MARK: - Textfield
    
    @objc func textField(_ textField: UITextField) -> Bool {
        
        text = plata.numberFormatter.string(from: NSNumber(value: percentage))
        
        let notZero = percentage > 0
        AMOUNT_FIELD_IS_EMPTY = !notZero
        
        plata.integer = self.integer
        
        if associatedButton != nil {
            associatedButton?.isEnabled = notZero
        }
        
        return false
    }
    
}
