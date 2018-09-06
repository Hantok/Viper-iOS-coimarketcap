//
//  TableViewController.swift
//  Coinmarketcap Test
//
//  Created by Roman Slysh on 9/6/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var presenter: TablePresenterInterface!
    var coins: Array<Coin> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Coins"
        self.clearsSelectionOnViewWillAppear = true
        presenter.getCoins(start: 1) { coins in
            self.coins = coins
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinId", for: indexPath)
        let coin = coins[indexPath.row]
        cell.textLabel?.text = coin.name
        cell.detailTextLabel?.text = "\(coin.symbol) = \(coin.price) USD"
        presenter.getImage(id: coin.id) { image in
            cell.imageView?.image = image
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            if self.tableView.tableFooterView == nil {
                let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                self.tableView.tableFooterView = spinner
            }
            self.tableView.tableFooterView?.isHidden = false
            let start = self.coins.count + 1
            presenter.getCoins(start: start) { coins in
                self.coins.append(contentsOf: coins)
                self.tableView.tableFooterView?.isHidden = true
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let coin = coins[indexPath.row]
        presenter.showCoinInfo(coin: coin)
    }

}

extension TableViewController: TableViewInterface {
    func show(_ viewController: UIViewController, animated: Bool) {
        self.present(viewController, animated: animated)
    }
}
