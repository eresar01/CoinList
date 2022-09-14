//
//  Coin.swift
//  CoinList
//
//  Created by Yerem Sargsyan on 12.09.22.
//

import Foundation

typealias Coins = [Coin]

struct CoinModel: Codable {
    let coins: Coins
}
// MARK: - Coin
struct Coin: Codable {
    var id: String
    var rank: Int?
    var name: String?
    var symbol: String?
    var iconUrl: String?
    var priceInUsd: Double?
    var priceInBtc: Double?
    var marketCapInUsd: Double?
    var percentChangeFor7h: Double?
    var percentChangeFor1h: Double?
    var percentChangeFor24h: Double?
    var volumeUsdForLast24h: Double?

    enum CodingKeys: String, CodingKey {
        case id = "i"
        case rank = "r"
        case name = "n"
        case symbol = "s"
        case iconUrl = "ic"
        case priceInUsd = "pu"
        case priceInBtc = "pb"
        case marketCapInUsd = "m"
        case percentChangeFor1h = "p1"
        case percentChangeFor7h = "p7"
        case volumeUsdForLast24h = "v"
        case percentChangeFor24h = "p24"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        rank = try container.decodeIfPresent(Int.self, forKey: .rank)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        symbol = try container.decodeIfPresent(String.self, forKey: .symbol)
        iconUrl = try container.decodeIfPresent(String.self, forKey: .iconUrl)
        priceInUsd = try container.decodeIfPresent(Double.self, forKey: .priceInUsd)
        priceInBtc = try container.decodeIfPresent(Double.self, forKey: .priceInBtc)
        marketCapInUsd = try container.decodeIfPresent(Double.self, forKey: .marketCapInUsd)
        percentChangeFor1h = try container.decodeIfPresent(Double.self, forKey: .percentChangeFor1h)
        percentChangeFor7h = try container.decodeIfPresent(Double.self, forKey: .percentChangeFor7h)
        percentChangeFor24h = try container.decodeIfPresent(Double.self, forKey: .percentChangeFor24h)
        volumeUsdForLast24h = try container.decodeIfPresent(Double.self, forKey: .volumeUsdForLast24h)
    }
    
    mutating func update(data: NSArray) {
        if let priceInUsd = data[2] as? Double, let priceInBtc = data[3] as? Double {
            self.priceInUsd = priceInUsd
            self.priceInBtc = priceInBtc
        }
    }
}
