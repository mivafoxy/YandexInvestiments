// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct QuotesInfo: Codable {
    let meta: Meta
    let data: [TrendingElement]
}

// MARK: - Datum
struct TrendingElement: Codable {
    let count: Int
    let quotes: [String]
    let jobTimestamp, startInterval: Int
}

// MARK: - Meta
struct Meta: Codable {
    let copyright, dataStatus: String

    enum CodingKeys: String, CodingKey {
        case copyright
        case dataStatus = "data_status"
    }
}
