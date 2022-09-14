//
//  CoinsViewModel.swift
//  CoinList
//
//  Created by Yerem Sargsyan on 13.09.22.
//

import Foundation
import UIKit

class CoinsViewModel {
    private var coinsService: CoinsServiceProtocol
    
    var reloadTableView: (() -> Void)?
    var updateTableView: (() -> Void)?
    var error: ((Alert.Error) -> Void)?
    
    var coins = Coins()
    var isUpdateing = false
    let updateTimeInterval: CGFloat = 5
    
    var coinCellViewModels = [CoinCellViewModel]() {
        didSet {
            if isUpdateing {
                updateTableView?()
                return
            }
            reloadTableView?()
        }
    }
    
    init(coinsService: CoinsServiceProtocol = CoinsService()) {
        self.coinsService = coinsService
    }
    
    func getCoins() {
        coinsService.getCoins { [weak self] coins, error in
            guard let self = self else { return }
            if let coins = coins {
                self.fetchData(coins: coins)
                DispatchQueue.global().asyncAfter(deadline: .now() + self.updateTimeInterval) {
                    self.updateCoins()
                }
            } else {
                if let error = error {
                    self.error?(self.errorData(error))
                }
            }
        }
    }
    
    func updateCoins() {
        coinsService.updateCoins { [weak self] array, error in
            guard let self = self else { return }
            if let array = array {
                self.isUpdateing = true
                DispatchQueue.global(qos: .userInteractive).async {
                    self.coinCellViewModels = self.coins.enumerated().map { (index, coin) in
                        var newCoin = coin
                        for item in array {
                            if item.count >= 4 ,let id = item[0] as? String, coin.id == id {
                                newCoin.update(data: item)
                                break
                            }
                        }
                        return self.createCellModel(index: index, coin: newCoin)
                    }
                }
            } else {
                if let error = error {
                    self.error?(self.errorData(error))
                }
            }
            
            DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + self.updateTimeInterval, execute: {
                self.updateCoins()
            })
        }
    }
    
    func fetchData(coins: Coins) {
        self.coins = coins // Cache
        var vms = [CoinCellViewModel]()
        for (index, coin) in coins.enumerated() {
            vms.append(createCellModel(index: index, coin: coin))
        }
        coinCellViewModels = vms
    }
    
    func createCellModel(index: Int, coin: Coin) -> CoinCellViewModel {
        let imageUrl = coin.iconUrl ?? ""
        let title = coin.name ?? ""
        let btc = coin.symbol ?? ""
        let index = "\(index + 1)"
        let price = (coin.priceInUsd ?? 0).currencyUS
        let percent = (coin.percentChangeFor24h ?? 0).persent
        
        return CoinCellViewModel(imageUrl: imageUrl,
                                 title: title,
                                 btc: btc,
                                 index: index,
                                 price: price,
                                 percent: percent)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> CoinCellViewModel {
        return coinCellViewModels[indexPath.row]
    }
    
    var configurePageData: PageModel {
        let name = "Coin List"
        let category = "Coin"
        let hour = "24h"
        let price = "Price"
        let arrowUp = UIImage(systemName: "arrowtriangle.up.fill")
        let arrowDown = UIImage(systemName: "arrowtriangle.down.fill")
        let curentPrice = "USD"
        return PageModel(name: name,
                         category: category,
                         hour: hour,
                         price: price,
                         arrowUp: arrowUp,
                         arrowDown: arrowDown,
                         curentPrice: curentPrice)
    }
    
    var networkData: Alert.Network {
        let title = "Internet Connect"
        let message = "Please connect to internet"
        let firstActionTitle = "ok"
        let secondActionTitle = "reload"
        return Alert.Network(title: title,
                           message: message,
                           firstActionTitle: firstActionTitle,
                           secondActionTitle: secondActionTitle)
    }
    
    func errorData(_ error: Error) -> Alert.Error {
        let title = "Error"
        let message = error.localizedDescription
        let firstActionTitle = "ok"
        let secondActionTitle = "reload"
        return Alert.Error(title: title,
                           message: message,
                           firstActionTitle: firstActionTitle,
                           secondActionTitle: secondActionTitle)
    }
}
