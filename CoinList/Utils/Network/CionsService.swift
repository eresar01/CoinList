//
//  CionsService.swift
//  CoinList
//
//  Created by Yerem Sargsyan on 12.09.22.
//

import Foundation
import Alamofire

//MARK: CionsServiceProtocol
protocol CoinsServiceProtocol {
    func getCoins(completion: @escaping ([Coin]? ,Error?) -> Void)
    func updateCoins(completion: @escaping ([NSArray]? ,Error?) -> Void)
}

//MARK: CionsService
class CoinsService: CoinsServiceProtocol {
    private let GET_COINS = "https://api.coin-stats.com/v3/coins"
    private let UPDATE_COINS = "https://api.coin-stats.com/v3/coins?responseType=array"
    
    //MARK: getCoins
    func getCoins(completion: @escaping (Coins? ,Error?) -> Void) {
        AF.request(GET_COINS, method: .get).responseDecodable(of: CoinModel.self) { response in
            switch response.result {
            case .success(let items):
                completion(items.coins, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    //MARK: updateCoins
    func updateCoins(completion: @escaping ([NSArray]? ,Error?) -> Void) {
        AF.request(UPDATE_COINS, method: .get).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    completion(nil, ServiceError.data)
                    return
                }
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                        completion(nil, ServiceError.serialization)
                        return
                    }
                    let array: [NSArray] = json["coins"] as? [NSArray] ?? []
                    completion(array, nil)
                } catch(let error) {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}

//MARK: Error
public enum ServiceError: Error {
    case data
    case serialization
    
    public var localizedDescription: String {
        switch self {
        case .data:
            return "data is nil"
        case .serialization:
            return "JSON cen not serialize"
        }
    }
}
