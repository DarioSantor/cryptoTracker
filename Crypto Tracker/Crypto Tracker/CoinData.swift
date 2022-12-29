//
//  CoinData.swift
//  Crypto Tracker
//
//  Created by Santos, Dario Ferreira on 29/12/2022.
//

import UIKit
import Alamofire

class CoinData {
    static let shared = CoinData()
    var coins = [Coin]()
    
    weak var delegate : DataCoinDelegate?
    
    private init() {
        let symbols = ["BTC", "ETH", "LTC", "DOGE"]
        
        for symbol in symbols {
            let coin = Coin(symbol: symbol)
            coins.append(coin)
        }
    }
    
    func getPrices() {
        var listOfSymbols = ""
        for coin in coins {
            listOfSymbols += coin.symbol
            if coin.symbol != coins.last?.symbol {
                listOfSymbols += ","
            }
        }
        
        Alamofire.request("https://min-api.cryptocompare.com/data/pricemulti?fsyms=\(listOfSymbols)&tsyms=EUR").responseJSON{
            (response) in
            if let json = response.result.value as? [String:Any] {
                for coin in self.coins {
                    if let coinJSON = json[coin.symbol] as?
                        [String: Double] {
                        if let price = coinJSON["EUR"] {
                            coin.price = price
                        }
                    }
                }
                
                self.delegate?.newPrices?()
            }
        }
    }
}

@objc protocol DataCoinDelegate : AnyObject {
    @objc optional func newPrices()
}

class Coin {
    var symbol = ""
    var image = UIImage()
    var price = 0.0
    var amount = 0.0
    var historicalData = [Double]()
    
    init(symbol: String) {
        self.symbol = symbol
        if let image = UIImage(named: symbol) {
            self.image = image
        }
    }
    
    func priceAsString() -> String {
        if price == 0.0 {
            return "Loading..."
        }
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_PT")
        formatter.numberStyle = .currency
        if let fancyPrice = formatter.string(from: NSNumber(floatLiteral: price)) {
            return fancyPrice
        } else {
            return "ERROR"
        }
    }
}
