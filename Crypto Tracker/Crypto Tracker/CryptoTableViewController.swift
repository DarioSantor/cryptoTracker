//
//  CryptoTableViewController.swift
//  Crypto Tracker
//
//  Created by Santos, Dario Ferreira on 29/12/2022.
//

import UIKit

class CryptoTableViewController: UITableViewController, DataCoinDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        CoinData.shared.delegate = self
        CoinData.shared.getPrices()
    }
    
    func newPrices() {
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoinData.shared.coins.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let coin = CoinData.shared.coins[indexPath.row]
        
        cell.textLabel?.text = "\(coin.symbol) - \(coin.priceAsString())"
        cell.imageView?.image = coin.image
        
        return cell
    }
}

