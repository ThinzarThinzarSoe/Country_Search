//
//  ErrorHandlerView.swift
//  AAAs
//

import UIKit

protocol ErrorHandlerDelegate: AnyObject {
    func didTapRetry()
}

class ErrorHandlerView: BaseView {
    
    @IBOutlet weak var imgError: UIImageView!
    @IBOutlet weak var lblErrorTitle: UILabel!
    @IBOutlet weak var lblErrorDesc: UILabel!
    @IBOutlet weak var btnRetry: RoundedCornerUIButton!
    @IBOutlet weak var widthConstraintForTryAgain: NSLayoutConstraint!
    
    weak var delegate : ErrorHandlerDelegate?
    
    override func setupUI() {
        super.setupUI()
        lblErrorTitle.font = .Roboto.Bold.font(size: 16)
        lblErrorDesc.font = .Roboto.Regular.font(size: 14)
        lblErrorTitle.textColor = .black
        lblErrorDesc.textColor = .black
        btnRetry.titleLabel?.font = .Roboto.Bold.font(size: 16)
        btnRetry.titleLabel?.textColor = .black
    }

    override func setupLanguage() {
        super.setupLanguage()
        btnRetry.setTitle("Try Again", for: .normal)
    }
    
    func setupView(isShow : Bool , title : String , description : String , image : UIImage, isServerError : Bool = false) {
        widthConstraintForTryAgain.constant = "Try Again".size(withAttributes: [.font: UIFont.Roboto.Bold.font(size: 16)]).width + 20
        var error_image : UIImage?
        var error_title : String?
        var error_desc : String?
        if !InternetConnectionManager.shared.isConnectedToNetwork() {
            error_image = UIImage(named: "ic_no_internet")
            error_title = ""
            error_desc = "No Internet"
            self.btnRetry.isHidden = false
            self.btnRetry.isUserInteractionEnabled = true
        } else {
            if isServerError {
                error_image = UIImage(named: "ic_no_server")
                error_title = "Server Error"
                error_desc = ""
                self.btnRetry.isHidden = false
                self.btnRetry.isUserInteractionEnabled = true
            } else {
                
                error_image = UIImage(named: "ic_no_data")
                error_title = "No Result Found"
                error_desc = ""
                self.btnRetry.isHidden = true
                self.btnRetry.isUserInteractionEnabled = false
            }
        }
        imgError.image = error_image
        lblErrorTitle.text = error_title
        lblErrorDesc.text = error_desc
    }

    func removeView() {
        removeFromSuperview()
    }
    
    override func bindData() {
        super.bindData()
        btnRetry.rx.tap.subscribe { _ in
            self.delegate?.didTapRetry()
            self.removeView()
        }.disposed(by: disposableBag)
    }
}


