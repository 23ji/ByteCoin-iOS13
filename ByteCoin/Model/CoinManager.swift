//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
  func didUpdatePrice(price: String, currency: String)
}

struct CoinManager {
  
  private enum API {
    static let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    static let apiKey = "4497EACB-469A-4FE9-BAB7-CBF13FB28198"
  }
  
  var delegate: CoinManagerDelegate?
  
  let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
  
  func getCoinPrice(for currency: String){
    let urlString = "\(API.baseURL)/\(currency)?apiKey=\(API.apiKey)"
    
    guard let url = URL(string: urlString) else { return }
    
    let urlSession = URLSession(configuration: .default)
    
    let task = urlSession.dataTask(with: url) { data, _, error in
      guard error == nil else { return }
      guard let data else { return }
      guard let coin = self.coin(data: data) else { return }

      let price = String(format: "%.1f", coin.rate)
      
      self.delegate?.didUpdatePrice(price: price, currency: currency)
    }
    task.resume()
  }
  
  private func coin(data: Data) -> Coin? {
    let decoder = JSONDecoder()
    let coin = try? decoder.decode(Coin.self, from: data)
    return coin
  }
}


