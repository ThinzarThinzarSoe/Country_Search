//
//  HomeModel.swift
//  Code_Test
//
//  Created by Thinzar Soe on 9/8/22.
//

import Foundation
import RxSwift

protocol HomeModelProtocol {
    func getCountryList() -> Observable<[CountryVO]?>
}

class HomeModel : HomeModelProtocol {
    deinit {
        
    }
}

extension HomeModel {
    func getCountryList() -> Observable<[CountryVO]?>{
        let url = ApiConfig.CountryList.getCountryList.getURLString()
        return ApiClient.shared.request(url: url).flatMap { responseData -> Observable<[CountryVO]?> in
            if let data = responseData as? Data {
                if let response = data.decode(modelType: [CountryVO].self) {
                    return Observable.just(response)
                }
            }
            return Observable.just(nil)
        }
    }
}
