//
//  InvestimentCardEntity.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 14.07.2021.
//

import Foundation

class InvestimentCardModel {
    private let timestamp: Int
    
    public let itemOpen: Double
    public var itemDate: Date {
        get {
            return Date(timeIntervalSince1970: Double(timestamp))
        }
    }
    
    public init(timestamp: String, itemOpen: Double) {
        self.timestamp = Int(timestamp) ?? 0
        self.itemOpen = itemOpen
    }
}
