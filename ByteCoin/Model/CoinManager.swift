//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCurrency(currenyPrice: String, currency: String)
    func didFailWithError(_ coinManager: CoinManager, error: Error)
}

struct CoinManager {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
       
    func getCoinPrice(for currency: String) {
            let urlString = "\(baseURL)\(currency)"
            
        
            // 1. Create a URL
            if let url = URL(string: urlString) {
            // 2. Create a session
                let session = URLSession(configuration: .default)
            
            // 3. Give session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(self,error: error!)
                    return
                }
                
                if let safeData = data {
                    //let dataString = String(data: safeData, encoding: .utf8)
                    //print(dataString)
                    
                    if let lastPrice = self.parseJSON(safeData) {
                        let priceString = String(format: "%.2f", lastPrice)
                        self.delegate?.didUpdateCurrency(currenyPrice: priceString, currency: currency)
                    }
                    
                }
            }
            
            // 4. Start the task
                task.resume()
                
            }
           
        }
        
    
    func performRequest(with urlString: String) {
        

    }
    
        func parseJSON(_ data: Data) -> Double?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.last
            //let changePrice = decodedData.changes.price.hour
            //print(lastPrice, changePrice)
            return lastPrice
        } catch {
           delegate?.didFailWithError(self, error: error)
            return nil
        }
    }
    
}
