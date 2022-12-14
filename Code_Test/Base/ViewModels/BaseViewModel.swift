//
//  BaseViewModel.swift
//  AAAs
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {
    var disposableBag = DisposeBag()
    weak var viewController : BaseViewController?
    
    let errorPublishRelay = PublishRelay<Error>()
    let showErrorMessagePublishRelay = PublishRelay<String>()
    let loadingPublishRealy = PublishRelay<Bool>()
    let isNoDataPublishRealy = PublishRelay<Bool>()
    let isNoInternetPublishRelay = PublishRelay<Bool>()
    let isSeverErrorPublishRelay = PublishRelay<Bool>()
    let isNoMoreDataPublishRealy = PublishRelay<Bool>()
    let showErrorMessageBehaviorRelay = BehaviorRelay<String>(value: "")
    var isShowNoDataPageForUnKnownError: Bool = true

    init() {
        
    }
    
    deinit {
        debugPrint("Deinit \(type(of: self))")
    }
    
    func bindViewModel(in viewController: BaseViewController? = nil,
                       isDataShowingPage: Bool = true) {
        self.viewController = viewController
        isShowNoDataPageForUnKnownError = isDataShowingPage
        
        loadingPublishRealy.bind { [weak self] (result) in
            if result {
                self?.viewController?.showLoading(true)
            } else {
                self?.viewController?.showLoading(false)
            }
        
        }.disposed(by: disposableBag)
        
        errorPublishRelay.bind { [weak self] (error) in
            self?.viewController?.showLoading(false)
            if let error = error as? URLError {
                switch error.code {
                case .notConnectedToInternet:
                    self?.isNoInternetPublishRelay.accept(true)
                default:
                    self?.isSeverErrorPublishRelay.accept(true)
                }
            }
        }.disposed(by: disposableBag)
        
        showErrorMessagePublishRelay.bind { [weak self] (errorMessage) in
            self?.viewController?.showToast(message: errorMessage, isShowing: {
                self?.viewController?.view.isUserInteractionEnabled = false
            }, completion: {
                self?.viewController?.view.isUserInteractionEnabled = true
            })
        }.disposed(by: disposableBag)
    }
}
