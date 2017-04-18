//
//  Plata.swift
//  Plata
//
//  Created by Tatiana Magdalena on 07/03/17.
//  Copyright © 2017 Tatiana Magdalena. All rights reserved.
//

import Foundation

public struct Plata {
    
    internal var numberFormatter: NumberFormatter = NumberFormatter()
    
    //public var spaceAfterSymbol: Bool = true
    
    public var integer: Int!
    public var realValue: Double! {
        return Double(integer)/100
    }
    
    public var onlyNumbers: String {
        return String(integer)
    }
    
    public var formattedString: String {
        return numberFormatter.string(from: NSNumber(value: realValue)) ?? ""
    }
    
    public var currencySymbol: CurrencySymbol = .fromCurrentLocale {
        didSet {
            PlataHelper.setCurrencySymbol(from: currencySymbol, to: numberFormatter)
        }
    }
    
    /// Decimal mark symbol, between the integer and the fractional part.
    public var decimalSeparator: String = "." {
        didSet {
            numberFormatter.currencyDecimalSeparator = decimalSeparator
        }
    }
    
    /// Thousand mark symbol.
    public var groupingSeparator: String = "," {
        didSet {
            numberFormatter.currencyGroupingSeparator = groupingSeparator
        }
    }
    
    public init(cents: Int) {
        self.integer = cents
        self.initializeNumberFormatter()
    }
    
    private func initializeNumberFormatter() {
        numberFormatter.numberStyle = .currency
        
        numberFormatter.currencyDecimalSeparator = decimalSeparator
        numberFormatter.currencyGroupingSeparator = groupingSeparator
        
        PlataHelper.setCurrencySymbol(from: currencySymbol, to: numberFormatter)
    }
    
}
