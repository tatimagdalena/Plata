//
//  CurrencyHelper.swift
//  Plata
//
//  Created by Tatiana Magdalena on 30/11/16.
//  Copyright © 2016 Tatiana Magdalena. All rights reserved.
//

import Foundation

public enum ValueLimit {
    case digits(Int)
    case cents(Int)
    case none
    
    public var limitValue: Int? {
        switch self {
        case .digits(let limit): return limit
        case .cents(let limit): return limit
        case .none: return nil
        }
    }
}

public enum CurrencySymbol {
    case code(String)
    case symbol(String)
    case fromCurrentLocale
    
    public var symbolString: String? {
        switch self {
        case .code(let code):
            return PlataHelper.currencySymbol(fromCode: code) ?? nil
        case .symbol(let symbol): return symbol
        case .fromCurrentLocale: return PlataHelper.currencySymbolFromLocale()
        }
    }
    
    public var codeString: String? {
        switch self {
        case .code(let code): return code
        case .symbol(_): return nil //TODO: check if there is a way to get code from symbol
        case .fromCurrentLocale: return PlataHelper.currencyCodeFromLocale()
        }
    }
}

internal struct PlataHelper {
 
    internal static func setCurrencySymbol(from type: CurrencySymbol, to numberFormatter: NumberFormatter) {
        
        switch type {
            
        case .code(let code):
            numberFormatter.currencyCode = code
            numberFormatter.currencySymbol = PlataHelper.currencySymbol(fromCode: code) ?? ""
            
        case .symbol(let symbol):
            numberFormatter.currencyCode = nil
            numberFormatter.currencySymbol = symbol
            
        case .fromCurrentLocale:
            let locale = Locale.current
            numberFormatter.currencySymbol = locale.currencyCode
            numberFormatter.currencySymbol = locale.currencySymbol
        }
    }
    
    internal static func currencySymbolFromLocale() -> String? {
        let locale = Locale.current
        return locale.currencySymbol
        
    }
    
    internal static func currencyCodeFromLocale() -> String? {
        let locale = Locale.current
        return locale.currencyCode
    }
    
    internal static func currencySymbol(fromCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: code)
    }
    
}
