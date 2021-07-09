//
//  InvestimentModel.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 08.07.2021.
//

import Foundation

class InvestimentModel {
    private let price: Double?
    private let change: Double?
    private let percent: Double?
    private let currency: String?
    
    private var sign: String {
        get {
            return isGrowing ? "+" : "-"
        }
    }
    
    public var isFavourite: Bool? = false
    public let companyName: String?
    public let symbol: String?
    
    public var regularPrice: String {
        get {
            guard let price = price else {
                return ""
            }
            
            return "\(getSymbol())\(nearestRound(price, toDecimalPlaces: 2))"
        }
    }
    
    public var dynamic: String {
        get {
            guard let change = change, let percent = percent else {
                return ""
            }
            
            return "\(sign)\(getSymbol())\(nearestRound(change, toDecimalPlaces: 2))(\(sign)\(nearestRound(percent, toDecimalPlaces: 2))%)"
        }
    }
    
    public var isGrowing: Bool {
        get {
            guard let change = change, let percent = percent else {
                return false
            }
            
            return change > 0 && percent > 0
        }
    }
    
    public init(_ symbol: String?, _ price: Double?, _ change: Double?, _ percent: Double?, _ companyName: String?, _ currency: String?) {
        self.symbol = symbol
        self.price = price
        self.change = change
        self.percent = percent
        self.companyName = companyName
        self.currency = currency
    }
    
    private func getSymbol() -> String {
        guard let currency = currency else {
            return ""
        }
        
        let locale = NSLocale(localeIdentifier: currency)
        return locale.displayName(forKey: .currencySymbol, value: currency) ?? ""
    }
    
    private func nearestRound(_ value: Double, toDecimalPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return abs(round(value * divisor) / divisor)
    }
}
