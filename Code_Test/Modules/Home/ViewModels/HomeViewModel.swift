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
    let countryListBehaviorRelay = BehaviorRelay<[CityVO]>(value: [])
    let keywordDataBehaviorRelay = BehaviorRelay<String>(value: "")
}

extension HomeViewModel {
    func getCountryList() {
        self.loadingPublishRealy.accept(true)
        model.getCountryList().subscribe(onNext: { [unowned self] (response) in
            let countryList = response?.sorted { $0.name ?? "" < $1.name ?? ""}
            countryListBehaviorRelay.accept(countryList ?? [])
            self.loadingPublishRealy.accept(false)
        }, onError: { [unowned self] (error) in
            self.loadingPublishRealy.accept(false)
            self.errorPublishRelay.accept(error)
        }).disposed(by: disposableBag)
    }
}
