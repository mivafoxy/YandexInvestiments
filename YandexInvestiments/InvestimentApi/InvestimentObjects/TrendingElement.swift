//
//  Trendings.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 08.07.2021.
//

import Foundation

struct TrendingElement: Codable {
    let count: Int
    let quotes: [String]
    let jobTimestamp: Int
    let startInterval: Int
}

typealias Trendings = [TrendingElement]
