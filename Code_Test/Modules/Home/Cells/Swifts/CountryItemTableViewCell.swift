//
//  CountryItemTableViewCell.swift
//  Code_Test
//
//  Created by Thinzar Soe on 9/8/22.
//

import UIKit

class CountryItemTableViewCell : BaseTableViewCell {
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblSubTitle : UILabel!
    @IBOutlet weak var heightConstrinat : NSLayoutConstraint!
    
    override func setupUI() {
        super.setupUI()
        heightForCountryView()
        lblTitle.textColor = .darkGray
        lblTitle.font = UIFont.Roboto.Bold.font(size: 14)
        lblSubTitle.textColor = .darkGray
        lblSubTitle.font = UIFont.Roboto.Regular.font(size: 14)
    }
    
    func heightForCountryView() {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            heightConstrinat.constant = UIScreen.main.bounds.width * 0.14
        } else {
            heightConstrinat.constant = UIScreen.main.bounds.height * 0.14
        }
    }
    
    override func layoutSubviews() {
        heightForCountryView()
    }
    
    func setupCell(data : CountryVO) {
        lblTitle.text = "\(data.name ?? "-"), \(data.country ?? "-")"
        lblSubTitle.text = "lat \(data.coord?.lat ?? 0.0) , long  \(data.coord?.lon ?? 0.0)"
    }
}
