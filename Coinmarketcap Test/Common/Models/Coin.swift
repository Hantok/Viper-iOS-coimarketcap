//
//  Coin.swift
//  Coinmarketcap Test
//
//  Created by Roman Slysh on 9/6/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Coin {
    let id: Int
    let name: String
    let symbol: String
    let rank: Int
    let price: String
    let volume24h: String
    let persentChange1h: String
    let persentChange24h: String
    let persentChange7d: String

    init?(_ json: JSON) {
        guard let id = json["id"].int else { return nil }
        guard let name = json["name"].string else { return nil }
        guard let symbol = json["symbol"].string else { return nil }
        guard let rank = json["rank"].int else { return nil }
        guard let price = json["quotes"]["USD"]["price"].double else { return nil }
        guard let volume24h = json["quotes"]["USD"]["volume_24h"].double else { return nil }
        guard let persentChange1h = json["quotes"]["USD"]["percent_change_1h"].double else { return nil }
        guard let persentChange24h = json["quotes"]["USD"]["percent_change_24h"].double else { return nil }
        guard let persentChange7d = json["quotes"]["USD"]["percent_change_7d"].double else { return nil }

        self.id = id
        self.name = name
        self.symbol = symbol
        self.rank = rank
        self.price = String(format: "%.2f", price)
        self.volume24h = String(format: "%.2f", volume24h)
        self.persentChange1h = String(format: "%.2f", persentChange1h)
        self.persentChange24h = String(format: "%.2f", persentChange24h)
        self.persentChange7d = String(format: "%.2f", persentChange7d)
    }
}
