//
//  BaseView.swift
//  TestVPN
//

import UIKit
import RxSwift

class BaseView : UIView {
    
    var disposableBag = DisposeBag()
    var view: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        bindData()
        setupLanguage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        bindData()
        setupLanguage()
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: "didChangeLanguage"), object: nil)
    }
    
    @objc func reload(){
        setupLanguage()
    }

    func setupUI() {
        self.view = self.loadViewFromNib()
        self.view.frame = self.bounds
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(self.view)
//        DispatchQueue.main.async {
//
//        }
    }
    
    func loadViewFromNib() -> UIView! {
        return UINib(nibName: String(describing: type(of: self)), bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView ?? UIView(frame: CGRect.zero)
    }
    
    func bindData() {
        
    }

    func setupLanguage() {
        
    }
    
    func setupTest() {
        
    }
}
