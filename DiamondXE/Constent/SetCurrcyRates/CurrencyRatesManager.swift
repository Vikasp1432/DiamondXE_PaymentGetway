//
//  CurrencyRatesManager.swift
//  DiamondXE
//
//  Created by iOS Developer on 27/06/24.
//

import Foundation
import Alamofire


// handl curny rate
struct CurrencyRates: Codable {
    var status: Int?
    var msg: String?
    var details: [CurrencyRateDetail]?
}

// MARK: - Detail
struct CurrencyRateDetail: Codable {
    var title, desc, currency, currencySymbol: String?
    var baseCurrency, currencyRate: String?
    var value: Double?
    var img: String?

    enum CodingKeys: String, CodingKey {
        case title, desc, currency
        case currencySymbol = "currency_symbol"
        case baseCurrency = "base_currency"
        case currencyRate = "currency_rate"
        case value, img
    }
}




class CurrencyRatesManager {
    
    static var shareInstence = CurrencyRatesManager()
    var currencyRateObj = CurrencyRates()
    var currencyRateStruct = [CurrencyRateDetail]()
    var currencyRateDetailObj = CurrencyRateDetail()
    
    func getCurrencyRates(){
        AlamofireManager().makeGETAPIRequestWithLocation(url: APIs().get_CurrencyRates_API, completion: { result in
            switch result {
            case .success(let data):
                do {
                    self.currencyRateObj = try JsonParsingManagar.parse(jsonData: data!, type: CurrencyRates.self)
                    self.currencyRateStruct = self.currencyRateObj.details ?? []
                    
                } catch {
                    print("Error")
                }
            case .failure(let error): break
                // Handle the error
            }
        })
    }
    
}



