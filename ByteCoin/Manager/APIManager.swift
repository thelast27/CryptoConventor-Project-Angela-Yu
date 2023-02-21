//
//  APIManager.swift
//  ByteCoin
//
//  Created by Eldar Garbuzov on 20.02.23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation
import UIKit


protocol CoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct APIManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    
    var coinIOApiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "coinIOApiKey") as? String else { return "" }
        return key
    }
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
            
        let urlString = "\(baseURL)/\(currency)?apikey=\(coinIOApiKey)"
            print(urlString)
            
            if let url = URL(string: urlString) {
                
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        self.delegate?.didFailWithError(error: error!)
                        return
                    }
                    
                    if let safeData = data {
                        if let bitcoinPrice = self.parseJSON(safeData) {
                            let priceString = String(format: "%.2f", bitcoinPrice)
                            self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                        }
                    }
                }
                task.resume()
            }
        }
    
    func parseJSON(_ data: Data) -> Double? {
            
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CurrencyModel.self, from: data)
                let lastPrice = decodedData.rate
                print(lastPrice)
                return lastPrice
                
            } catch {
                delegate?.didFailWithError(error: error)
                return nil
            }
        }
}


