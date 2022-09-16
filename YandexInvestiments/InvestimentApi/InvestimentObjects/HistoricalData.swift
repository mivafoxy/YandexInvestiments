// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let historicalData = try? newJSONDecoder().decode(HistoricalData.self, from: jsonData)

import Foundation

// MARK: - HistoricalData
struct HistoricalData: Codable {
    let meta: HistoricalDataMeta
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let meta: DataMeta
    let items: [String: Item]
    let error: JSONNull?
}

// MARK: - Item
struct Item: Codable {
    let date: String
    let dateUTC: Int
    let itemOpen, high, low, close: Double
    let volume: Int
    let adjclose: Double

    enum CodingKeys: String, CodingKey {
        case date
        case dateUTC = "date_utc"
        case itemOpen = "open"
        case high, low, close, volume, adjclose
    }
}

// MARK: - DataMeta
struct DataMeta: Codable {
    let currency, symbol, exchangeName, instrumentType: String
    let firstTradeDate, regularMarketTime, gmtoffset: Int
    let timezone, exchangeTimezoneName: String
    let regularMarketPrice, chartPreviousClose: Double
    let priceHint: Int
    let dataGranularity, range: String
}

// MARK: - HistoricalDataMeta
struct HistoricalDataMeta: Codable {
    let copyright, dataStatus: String

    enum CodingKeys: String, CodingKey {
        case copyright
        case dataStatus = "data_status"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
