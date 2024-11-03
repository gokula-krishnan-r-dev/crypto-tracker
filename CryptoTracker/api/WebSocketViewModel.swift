//
//  WebSocketViewModel.swift
//  CryptoTracker
//
//  Created by Gokula Krishnan R on 16/01/24.
//

import SwiftUI
import Combine

class WebSocketService : ObservableObject {
  
    private let urlSession = URLSession(configuration: .default)
    private var webSocketTask: URLSessionWebSocketTask?
    
    private let baseURL = URL(string: "ws://localhost:3000?coin=bitcoin")!
    
    let didChange = PassthroughSubject<Void, Never>()
    @Published var marketDetailsHeader: String = ""
    
    private var cancellable: AnyCancellable? = nil
    
    var priceResult: String = "" {
        didSet {
            didChange.send()
        }
    }

    init() {
//        cancellable = AnyCancellable($price
//            .debounce(for: 0.5, scheduler: DispatchQueue.main)
//            .removeDuplicates()
//            .assign(to: \.priceResult, on: self))
        print(marketDetailsHeader)
    }
    
    func connect() {
            
            stop()
            webSocketTask = urlSession.webSocketTask(with: baseURL)
            webSocketTask?.resume()
            
            sendMessage()
            receiveMessage()
        }

        func stop() {
            webSocketTask?.cancel(with: .goingAway, reason: nil)
        }
        
        private func sendMessage()
        {
            let string = "list,bitcoin"
            
            let message = URLSessionWebSocketTask.Message.string(string)
            webSocketTask?.send(message) { error in
                if let error = error {
                    print("WebSocket couldn’t send message because: \(error)")
                }
            }
        }
        
    private func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("Error in receiving message: \(error)")
            case .success(.string(let str)):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(CoinData.self, from: Data(str.utf8))
//                    print(result)
                    // Convert CoinData to a JSON string for marketDetailsHeader
                    if let jsonString = self?.convertObjectToJSONString(result) {
                        DispatchQueue.main.async {
                            self?.marketDetailsHeader = "\(jsonString)"
                            print(jsonString)
                        }
                    }
                } catch  {
                    print("error is \(error.localizedDescription)")
                }
                
                self?.receiveMessage()
            default:
                print("default")
            }
        }
    }

    private func convertObjectToJSONString<T: Encodable>(_ object: T) -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(object)
            if let jsonString = String(data: data, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("Error converting object to JSON string: \(error)")
        }
        return nil
    }
}
