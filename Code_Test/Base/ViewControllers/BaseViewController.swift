//
//  BaseViewController.swift
//  TestVPN
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class BaseViewController : UIViewController {
    
    var disposableBag = DisposeBag()
    var errorHandlerView : ErrorHandlerView?
    let barLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindData()
        bindViewModel()
        setupLanguage()
        setNavigationColor()
    }
    
    func setupUI() {
        
    }
    
    func bindData() {
        
    }
    
    func setupLanguage(){
        
    }
    
    func bindViewModel() {
        
    }
    
    func reloadScreen() {
        setupUI()
        setNavigationColor()
        setupLanguage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppScreens.shared.currentVC = self
        checkViewControllerAndAddBackBtn(vc: self)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: "didChangeLanguage"), object: nil)
    }
    
    @objc func reload(){
        setupLanguage()
    }
    
    func isShowNavigationBar(_ isShow : Bool) {
        navigationController?.setNavigationBarHidden(!isShow, animated: true)
    }
    
    func isShowNavigationBorder(_ isShow : Bool){
        navigationController?.isHiddenUnderline = !isShow
    }
    
    func checkViewControllerAndAddBackBtn(vc : UIViewController) {
        if !isTopViewController(vc: vc){
            addBackButton()
            isShowNavigationBar(true)
        } else {
            isShowNavigationBar(false)
        }
    }
    
    func isTopViewController(vc : UIViewController) -> Bool {
        return navigationController?.children.first == vc
    }
    
    func setNavigationColor(){
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .white
            appearance.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.black,NSAttributedString.Key.font: UIFont.Roboto.Bold.font(size: 16)]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
            if let navigationBar = navigationController?.navigationBar {
                let navigationLayer = CALayer()
                var bounds = navigationBar.bounds
                navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.black,NSAttributedString.Key.font: UIFont.Roboto.Bold.font(size: 16)]
                let orient = UIDevice.current.orientation
                if orient == .landscapeLeft || orient == .landscapeRight {
                    bounds.size.height = 200
                    bounds.size.width = self.view.frame.width
                } else {
                    bounds.size.height = 100
                    bounds.size.width = self.view.frame.width
                }
                navigationLayer.frame = bounds
                navigationLayer.backgroundColor = UIColor.white.cgColor

                if let image = getImageFrom(layer: navigationLayer) {
                    navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
                }
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        setNavigationColor()
    }
    
    func isShowNoDataAndInternet(isShow : Bool , isServerError : Bool = false, errorImage: UIImage? = nil, errorTitle: String? = nil, errorDesc: String? = nil) {
        errorHandlerView?.removeFromSuperview()
        errorHandlerView = ErrorHandlerView(frame: view.frame)
        errorHandlerView?.translatesAutoresizingMaskIntoConstraints = false
        errorHandlerView?.delegate = self
        if isShow {
            errorHandlerView?.setupView(isShow: isShow, title: errorTitle ?? "", description: errorDesc ?? "", image: errorImage ?? UIImage(), isServerError: isServerError)
            view.addSubview(errorHandlerView!)
            errorHandlerView?.snp.makeConstraints({ (errorView) in
                errorView.left.equalToSuperview()
                errorView.right.equalToSuperview()
                errorView.centerY.equalToSuperview()
            })
            
        } else {
            errorHandlerView?.removeView()
        }
    }
}

extension BaseViewController : ErrorHandlerDelegate {
    func didTapRetry() {
       if InternetConnectionManager.shared.isConnectedToNetwork() {
            isShowNoDataAndInternet(isShow: false)
            reloadScreen()
        } else {
            showNoInternetConnectionToast()
            isShowNoDataAndInternet(isShow: true)
        }
    }
}
