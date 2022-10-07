//
//  HomeScreen.swift
//  Code_Test
//
//  Created by Thinzar Soe on 9/9/22.
//

import Foundation

class HomeScreen {
    
    enum HomeVC {
        case navigateToMapViewVC(_ countryData : CountryVO)
        
        func show() {
            switch self {
            case .navigateToMapViewVC(let countryData):
                AppScreens.shared.navigateToMapViewVC(countryData)
            }
        }
    }
    
    enum MapVC {
        case goBackToHomeVC
        
        func show() {
            switch self {
            case .goBackToHomeVC:
                AppScreens.shared.backToHomeVC()
            }
        }
    }
}
