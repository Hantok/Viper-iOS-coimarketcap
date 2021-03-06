//
//  TableInterfaces.swift
//  Coinmarketcap Test
//
//  Created by Roman Slysh on 9/5/18.
//  Copyright (c) 2018 Roman. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

enum TableNavigationOption {
}

protocol TableWireframeInterface: WireframeInterface {
    func navigate(to option: TableNavigationOption)
}

protocol TableViewInterface: ViewInterface {
    func show(_ viewController: UIViewController, animated: Bool)
}

protocol TablePresenterInterface: PresenterInterface {
    func getCoins(start: Int, complation: @escaping CoinCallback)
    func getImage(id: Int, complation: @escaping ImageCallback)
    func showCoinInfo(coin: Coin)
}
protocol TableInteractorInterface: InteractorInterface {
}
