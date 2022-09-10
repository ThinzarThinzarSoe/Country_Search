//
//  BaseTableViewCell.swift
//  TestVPN
//

import UIKit
import RxCocoa
import RxSwift

class BaseTableViewCell : UITableViewCell {
    
    var disposableBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupUI()
        bindData()
        setupLanguage()
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: "didChangeLanguage"), object: nil)
    }
    
    @objc func reload(){
        setupLanguage()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupUI() {
        
    }
    
    func bindData() {
        
    }
    
    func setupLanguage(){
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposableBag = DisposeBag()
        bindData()
    }
    
    func setupTest() {

    }
}
