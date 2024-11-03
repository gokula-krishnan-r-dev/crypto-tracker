//
//  HeroView.swift
//  CryptoTracker
//
//  Created by Gokula Krishnan R on 09/01/24.
//

import SwiftUI
struct PokedexElement: Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice, marketCap, marketCapRank, fullyDilutedValuation: Int
    let totalVolume, high24H, low24H: Int
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double
    let circulatingSupply, totalSupply, maxSupply, ath: Int
    let athChangePercentage: Double
    let athDate: String
    let atl, atlChangePercentage: Double
    let atlDate: String
    let roi: JSONNull?
    let lastUpdated: String

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case roi
        case lastUpdated = "last_updated"
    }
}

typealias Pokedex = [PokedexElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
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
struct HeroView: View {

    @ObservedObject var service = WebSocketService()

    @Binding var chartData: [PriceChart]
    @State private var coinDetails: [PokedexElement] = []
    @ObservedObject var viewModel: PopoverCoinViewModel
    var body: some View {
        VStack(alignment: .leading){
           
            HeaderScroll()
            if let firstCoin = coinDetails.first {
                HStack{
                    Text("Rank #\(firstCoin.marketCapRank)")
                        .font(.system(size: 12 , weight: .medium) )
                        .padding(.vertical , 4)
                        .padding(.horizontal , 12)
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .cornerRadius(44)
                    Spacer()
                }
                VStack{
                    HStack{
//                        Image(systemName: "square.and.arrow.up.circle.fill")
//                            .font(.system(size: 34))
//                    
                        if let firstCoin = coinDetails.first, let logoURL = URL(string: firstCoin.image) {
                                                AsyncImage(url: logoURL) { phase in
                                                    switch phase {
                                                    case .success(let image):
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 44, height: 44) // Set the desired size here
                                                            .clipShape(Circle()) // Optional: Clip the image to a circle
                                                    case .failure:
                                                        // Handle failure, e.g., display a placeholder
                                                        Image(systemName: "photo.fill")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 55, height: 55)
                                                            .foregroundColor(.gray)
                                                            .clipShape(Circle())
                                                    case .empty:
                                                        // Handle empty state, e.g., display a placeholder
                                                        Image(systemName: "photo.fill")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 55, height: 55)
                                                            .foregroundColor(.gray)
                                                            .clipShape(Circle())
                                                    @unknown default:
                                                        // Handle unknown state
                                                        EmptyView()
                                                    }
                                                }
                                                .frame(width: 55, height: 55)
                                            }
                         
                        Text(firstCoin.name)
                            .font(.system(size: 24, weight: .semibold))
                        
                        
                        Text("\(firstCoin.symbol) Price")
                            .font(.system(size: 16  ,weight: .regular))
                            .foregroundStyle(Color.gray)
                            .textCase(.uppercase)
                    }
                }
                VStack(alignment: .leading){
                    HStack{
                        Text(viewModel.subtitle)
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: 140)
                        Divider()
                            .frame(height: 26)
                        HStack{
                            // Display market cap change percentage
                            let marketCapChangePercentage = firstCoin.priceChangePercentage24H
                            let formattedPercentage = String(format: "%.1f%%", marketCapChangePercentage)

                            Image(systemName: "arrowtriangle.up.fill")
                                .font(.system(size: 18))
                                .foregroundColor(marketCapChangePercentage < 0 ? .red : .green)
                                .rotationEffect(Angle(degrees: marketCapChangePercentage < 0 ? 180 : 0))
                          
                             Text(formattedPercentage)
                                .font(.system(size: 20 , weight: .heavy))
                                 .foregroundColor(marketCapChangePercentage < 0 ? .red : .green)
                        }
                        Divider()
                            .frame(height: 26)
                        HStack{
                            
                            
                            Image(systemName: "arrowtriangle.up.fill")
                                .font(.system(size: 18))
                                .foregroundColor(.green)
                            Text("$3,232")
                            
                        }
                        HStack{
                            ShareButton(label: "Share", systemImageName: "square.and.arrow.up") {
                                print("clicked")
                            }
                            ShareButton(label: "Share", systemImageName: "square.and.arrow.up") {
                                print("clicked")
                            }
                            ShareButton(label: "Share", systemImageName: "square.and.arrow.up") {
                                print("clicked")
                            }
                        }
                    }
                    VStack{
                        ZStack(alignment: .leading){
                            
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 400, height: 8)
                                .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                                .cornerRadius(52)
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 300, height: 8)
                                .background(Color(red: 0.6, green: 0.86, blue: 0.42))
                                .cornerRadius(52)
                            
                        }
                        HStack{
                            Text("$\(firstCoin.low24H)")
                                .font(.system(size: 12 , weight: .semibold))
                            Spacer()
                            Text("24h Range")
                                .font(.system(size: 12 , weight: .semibold))
                            Spacer()
                            // Calculate the percentage change
                                      let percentageChange = ((firstCoin.currentPrice - firstCoin.low24H) / firstCoin.currentPrice)
                                      
                                      // Display the percentage change
                                      Text("Percentage Change: \(percentageChange)%")
                                          .foregroundColor(percentageChange < 0 ? .red : .green)
                            Text("$\(firstCoin.high24H)")
                                .font(.system(size: 12 , weight: .semibold))
                            Text("\(service.marketDetailsHeader) data")
                        }
                    }
                    .frame(maxWidth: 400)
                    .padding(.vertical)
//                    VStack(alignment: .leading){
//                        VStack{
//                            Text("Market Info")
//                                .font(.system(size: 18 , weight: .medium))
//                        }
//                        .padding(.vertical , 12)
//                        VStack(alignment:.leading){
//                            Text("Market Cap")
//                                .font(.system(size: 12 , weight: .medium))
//                            Text("$3434,3434")
//                                .font(.title)
//                                .fontWeight(.bold)
//                        }
//                    }
                    
                }
            }
        }
        .onAppear{
//            print(websocket.messages , "data")
//            websocket.sendMessage("header,bitcoin")
//            websocket.sendMessage("list,bitcoin")
            self.service.connect()
            fetchData()
        }
        .frame(maxWidth: .infinity)
        
    }
    func fetchData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let posts = try JSONDecoder().decode([PokedexElement].self, from: data)
                DispatchQueue.main.async {
                    self.coinDetails = posts
//                    print(self.coinDetails)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
 
}

