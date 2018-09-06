//
//  Network.swift
//  Coinmarketcap Test
//
//  Created by Roman Slysh on 9/6/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias SwiftyJSONCallback = (HTTPURLResponse?, JSON) -> Void

final class Network {
    static var additionalHeaders = [String: String]()

    static var manager: SessionManager = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "romanslysh.coinmarketcaptest.background")
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 15
        configuration.httpAdditionalHeaders?["Content-Type"] = "application/json"
        return SessionManager(configuration: configuration)
    }()
}

extension DataRequest {
    @discardableResult
    func responseSwiftyJSON(_ callback: @escaping SwiftyJSONCallback) -> DataRequest {
        return response { dataResponse in
            let json: JSON
            if let data = dataResponse.data {
                json = JSON(data)
            } else {
                json = JSON.null
            }

            callback(dataResponse.response, json)
        }
    }
}

extension SessionManager {
    @discardableResult
    func requestMarketCap(path: String, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: [String: String] = Network.additionalHeaders, encoding: ParameterEncoding = JSONEncoding.default) -> DataRequest? {
        let route = Constants.baseURLString + path
        dLog("\(method) \(path)")

        guard let url = URL(string: route) else {
            aLog("Error - wrong URL \(route)")
            return nil
        }

        return request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }

    func requestLogo(id: String, method: HTTPMethod = .get) -> DataRequest? {
        let route = Constants.logoURLString + id
        dLog("\(method) \(route)")

        guard let url = URL(string: route) else {
            aLog("Error - wrong URL \(route)")
            return nil
        }

        return request(url, method: method)
    }
}
