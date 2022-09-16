// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let quote = try? newJSONDecoder().decode(Quote.self, from: jsonData)

import Foundation

// MARK: - Quote
struct Quote: Codable {
    let meta: Meta
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let ask: Double
    let askSize: Int?
    let averageDailyVolume10Day, averageDailyVolume3Month: Int
    let bid: Double
    let bidSize: Int?
    let bookValue: Double?
    let currency: String
    let dividendDate, earningsTimestamp, earningsTimestampStart, earningsTimestampEnd: RegularMarketTime?
    let epsForward, epsTrailingTwelveMonths: Double?
    let exchange: String
    let exchangeDataDelayedBy: Int
    let exchangeTimezoneName: String
    let exchangeTimezoneShortName: String
    let fiftyDayAverage, fiftyDayAverageChange, fiftyDayAverageChangePercent, fiftyTwoWeekHigh: Double
    let fiftyTwoWeekHighChange, fiftyTwoWeekHighChangePercent, fiftyTwoWeekLow, fiftyTwoWeekLowChange: Double
    let fiftyTwoWeekLowChangePercent: Double
    let financialCurrency: String?
    let forwardPE: Double?
    let fullExchangeName: String
    let gmtOffSetMilliseconds: Int
    let language: String
    let longName: String?
    let market: String
    let marketCap: Int?
    let marketState: String
    let messageBoardID: String?
    let postMarketChange, postMarketChangePercent, postMarketPrice, postMarketTime: JSONNull?
    let priceHint: Int
    let priceToBook: Double?
    let quoteSourceName: String
    let quoteType: String
    let regularMarketChange, regularMarketChangePercent, regularMarketDayHigh, regularMarketDayLow: Double
    let regularMarketOpen, regularMarketPreviousClose, regularMarketPrice: Double
    let regularMarketTime: RegularMarketTime
    let regularMarketVolume: Int
    let sharesOutstanding: Int?
    let shortName: String?
    let sourceInterval: Int
    let symbol: String
    let tradeable: Bool
    let trailingAnnualDividendRate, trailingAnnualDividendYield, trailingPE: Double?
    let twoHundredDayAverage, twoHundredDayAverageChange, twoHundredDayAverageChangePercent: Double

    enum CodingKeys: String, CodingKey {
        case ask, askSize, averageDailyVolume10Day, averageDailyVolume3Month, bid, bidSize, bookValue, currency, dividendDate, earningsTimestamp, earningsTimestampStart, earningsTimestampEnd, epsForward, epsTrailingTwelveMonths, exchange, exchangeDataDelayedBy, exchangeTimezoneName, exchangeTimezoneShortName, fiftyDayAverage, fiftyDayAverageChange, fiftyDayAverageChangePercent, fiftyTwoWeekHigh, fiftyTwoWeekHighChange, fiftyTwoWeekHighChangePercent, fiftyTwoWeekLow, fiftyTwoWeekLowChange, fiftyTwoWeekLowChangePercent, financialCurrency, forwardPE, fullExchangeName, gmtOffSetMilliseconds, language, longName, market, marketCap, marketState
        case messageBoardID = "messageBoardId"
        case postMarketChange, postMarketChangePercent, postMarketPrice, postMarketTime, priceHint, priceToBook, quoteSourceName, quoteType, regularMarketChange, regularMarketChangePercent, regularMarketDayHigh, regularMarketDayLow, regularMarketOpen, regularMarketPreviousClose, regularMarketPrice, regularMarketTime, regularMarketVolume, sharesOutstanding, shortName, sourceInterval, symbol, tradeable, trailingAnnualDividendRate, trailingAnnualDividendYield, trailingPE, twoHundredDayAverage, twoHundredDayAverageChange, twoHundredDayAverageChangePercent
    }
}

// MARK: - RegularMarketTime
struct RegularMarketTime: Codable {
    let date: String
    let timezoneType: Int
    let timezone: String

    enum CodingKeys: String, CodingKey {
        case date
        case timezoneType = "timezone_type"
        case timezone
    }
}


