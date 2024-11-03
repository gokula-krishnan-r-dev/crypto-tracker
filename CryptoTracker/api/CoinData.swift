//
//  File.swift
//  CryptoTracker
//
//  Created by Gokula Krishnan R on 16/01/24.
//

import Foundation

//// MARK: - Welcome
//struct CoinData: Decodable {
//    let assets: Assets
//}
//
//// MARK: - Assets
//struct Assets: Codable {
//    let pageInfo: PageInfo
//    let edges: [Edge]
//}
//
//// MARK: - Edge
//struct Edge: Codable {
//    let cursor: String
//    let node: Node
//}
//
//// MARK: - Node
//struct Node: Codable {
//    let changePercent24Hr, name, id, logo: String
//    let marketCapUsd, priceUsd: String
//    let rank: Int
//    let supply, symbol, volumeUsd24Hr: String
//    let vwapUsd24Hr: String?
//}
//
//// MARK: - PageInfo
//struct PageInfo: Codable {
//    let startCursor, endCursor: String
//    let hasNextPage, hasPreviousPage: Bool
//}

// MARK: - Welcome
struct CoinData: Codable {
    let marketTotal: MarketTotal
    let asset: Asset
}

// MARK: - Asset
struct Asset: Codable {
    let priceUsd, marketCapUsd, volumeUsd24Hr, typename: String

    enum CodingKeys: String, CodingKey {
        case priceUsd, marketCapUsd, volumeUsd24Hr
        case typename = "__typename"
    }
}

// MARK: - MarketTotal
struct MarketTotal: Codable {
    let marketCapUsd, exchangeVolumeUsd24Hr, assets, exchanges: String
    let markets, typename: String

    enum CodingKeys: String, CodingKey {
        case marketCapUsd, exchangeVolumeUsd24Hr, assets, exchanges, markets
        case typename = "__typename"
    }
}
