//
//  MarketCapService.swift
//  Coinmarketcap Test
//
//  Created by Roman Slysh on 9/6/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

typealias CoinCallback = (Array<Coin>) -> Void
typealias ImageCallback = (UIImage?) -> Void

class MarketCapService: NSObject {
    static func tickerRequest(start: Int = 1, limit: Int = 20, completion: @escaping CoinCallback) {
        Network.manager.requestMarketCap(path: "\(Constants.ticker)?sord=id&start=\(start)&limit=\(limit)")?.responseSwiftyJSON { _, json in
            guard let dict = json.dictionary?["data"]?.dictionary else {
                aLog("Error: no data")
                return
            }
            let coins = Array(dict.values).compactMap({ Coin($0) }).sorted(by: { $0.rank < $1.rank })
            completion(coins)
        }
    }

    static func loadImage(_ id: Int, completion: @escaping ImageCallback) {
        Network.manager.requestLogo(id: "\(id).png")?.responseData { data in
            if let data = data.data {
                completion(UIImage.init(data: data, scale: 1))
            } else {
                dLog("Image not loaded for id \(id)")
                completion(nil)
            }
        }
    }
}
