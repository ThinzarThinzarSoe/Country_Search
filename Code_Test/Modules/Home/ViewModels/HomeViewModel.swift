//
//  HomeViewModel.swift
//  Code_Test
//
//  Created by Thinzar Soe on 9/8/22.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel : BaseViewModel {
    
    private let model: HomeModelProtocol
    init(model: HomeModelProtocol = HomeModel()) {
        self.model = model
    }
    
    let countryListBehaviorRelay = BehaviorRelay<[CountryResponse]>(value: [])
    let searchCountryListBehaviorRelay = BehaviorRelay<[CountryResponse]>(value: [])
}

extension HomeViewModel {
    func getCountryList() {
        self.loadingPublishRealy.accept(true)
        model.getCountryList().subscribe(onNext: { [unowned self] (response) in
            self.loadingPublishRealy.accept(false)
            countryListBehaviorRelay.accept(response ?? [])
        }, onError: { [unowned self] (error) in
            self.loadingPublishRealy.accept(false)
            self.errorPublishRelay.accept(error)
        }).disposed(by: disposableBag)
    }
}
