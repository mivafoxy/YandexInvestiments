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
    let currency: Currency
    let dividendDate, earningsTimestamp, earningsTimestampStart, earningsTimestampEnd: RegularMarketTime?
    let epsForward, epsTrailingTwelveMonths: Double?
    let exchange: String
    let exchangeDataDelayedBy: Int
    let exchangeTimezoneName: ExchangeTimezoneName
    let exchangeTimezoneShortName: ExchangeTimezoneShortName
    let fiftyDayAverage, fiftyDayAverageChange, fiftyDayAverageChangePercent, fiftyTwoWeekHigh: Double
    let fiftyTwoWeekHighChange, fiftyTwoWeekHighChangePercent, fiftyTwoWeekLow, fiftyTwoWeekLowChange: Double
    let fiftyTwoWeekLowChangePercent: Double
    let financialCurrency: FinancialCurrency?
    let forwardPE: Double?
    let fullExchangeName: String
    let gmtOffSetMilliseconds: Int
    let language: Language
    let longName: String?
    let market: Market
    let marketCap: Int?
    let marketState: MarketState
    let messageBoardID: String?
    let postMarketChange, postMarketChangePercent, postMarketPrice, postMarketTime: JSONNull?
    let priceHint: Int
    let priceToBook: Double?
    let quoteSourceName: QuoteSourceName
    let quoteType: QuoteType
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

enum Currency: String, Codable {
    case hkd = "HKD"
    case nok = "NOK"
    case usd = "USD"
}

// MARK: - RegularMarketTime
struct RegularMarketTime: Codable {
    let date: String
    let timezoneType: Int
    let timezone: Timezone

    enum CodingKeys: String, CodingKey {
        case date
        case timezoneType = "timezone_type"
        case timezone
    }
}

enum Timezone: String, Codable {
    case the0000 = "+00:00"
}

enum ExchangeTimezoneName: String, Codable {
    case americaNewYork = "America/New_York"
    case asiaHongKong = "Asia/Hong_Kong"
    case europeLondon = "Europe/London"
    case europeOslo = "Europe/Oslo"
}

enum ExchangeTimezoneShortName: String, Codable {
    case bst = "BST"
    case cest = "CEST"
    case edt = "EDT"
    case hkt = "HKT"
}

enum FinancialCurrency: String, Codable {
    case cny = "CNY"
    case usd = "USD"
}

enum Language: String, Codable {
    case enUS = "en-US"
}

enum Market: String, Codable {
    case ccyMarket = "ccy_market"
    case hkMarket = "hk_market"
    case noMarket = "no_market"
    case us24Market = "us24_market"
    case usMarket = "us_market"
}

enum MarketState: String, Codable {
    case postpost = "POSTPOST"
    case pre = "PRE"
    case regular = "REGULAR"
}

enum QuoteSourceName: String, Codable {
    case delayedQuote = "Delayed Quote"
    case nasdaqRealTimePrice = "Nasdaq Real Time Price"
}

enum QuoteType: String, Codable {
    case currency = "CURRENCY"
    case equity = "EQUITY"
    case etf = "ETF"
    case future = "FUTURE"
}
