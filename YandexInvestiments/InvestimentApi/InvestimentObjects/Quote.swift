// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let quotes = try? newJSONDecoder().decode(Quotes.self, from: jsonData)

import Foundation

// MARK: - Quote
struct Quote: Decodable {
    let currency: String?
    let regularMarketChange, regularMarketChangePercent, regularMarketDayHigh, regularMarketDayLow: Double?
    let regularMarketOpen, regularMarketPreviousClose, regularMarketPrice: Double?
    let shortName: String?
    let symbol: String?
}
 typealias Quotes = [Quote]
