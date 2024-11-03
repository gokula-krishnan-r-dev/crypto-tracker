//
//  ChartCardView.swift
//  CryptoTracker
//
//  Created by Gokula Krishnan R on 13/01/24.
//

import SwiftUI
import Charts

// MARK: - Chartdata
struct Chartdata: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable, Identifiable {
    let id = UUID() // Add an 'id' property for Identifiable
    let priceUsd: String
    let time: TimeInterval
    let date: String
}
struct ChartCardView: View {
    @State private var chartdata: Chartdata? = nil
    @ObservedObject var viewModel: PopoverCoinViewModel
    var body: some View {
        VStack {
                   if let data = chartdata {
                       GroupBox("BitCoin") {
                           Chart(data.data) { value in
                               LineMark(
                                   x: .value("Hour", value.date),
                                   y: .value("Price", Double(value.priceUsd) ?? 0.0)
                               )
                               .interpolationMethod(.catmullRom)

                               AreaMark(
                                   x: .value("Hour", value.date),
                                   y: .value("Price", Double(value.priceUsd) ?? 0.0)
                               )
                               .interpolationMethod(.catmullRom)
                               .foregroundStyle(Color("Blue").opacity(0.1).gradient)
                           }
                           .padding()
                           .chartYAxis() {
                               AxisMarks(position: .leading)
                           }
                           .frame(height: 250)
                           .chartYScale(domain: Double(data.data.min { $0.priceUsd < $1.priceUsd }?.priceUsd ?? "0")!...Double(data.data.max { $0.priceUsd < $1.priceUsd }?.priceUsd ?? "0")!)
                           .chartLegend(position: .overlay, alignment: .top)
                       }
                   } else {
                       Text("Loading...")
                   }
            
               }
        .onAppear {
            fetchData()
        }
    }
    func getCurrentTime() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return dateFormatter.string(from: Date())
        }

        func getCurrentUnixTimestamp() -> TimeInterval {
            return Date().timeIntervalSince1970
        }

    func getUnixTimestampAgo() -> TimeInterval {
        let timeInterval = 3600
        let agoDate = Date().addingTimeInterval(TimeInterval(-timeInterval))
        return agoDate.timeIntervalSince1970
    }

    func fetchData() {
        guard let url = URL(string: "https://api.coincap.io/v2/assets/bitcoin/history?interval=d1") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let chartData = try JSONDecoder().decode(Chartdata.self, from: data)
                DispatchQueue.main.async {
                    self.chartdata = chartData
                }
           
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

//struct ChartCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartCardView(viewModel: view)
//    }
//}
