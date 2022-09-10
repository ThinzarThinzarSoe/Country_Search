
import UIKit

class AppScreens {
    static var shared = AppScreens()
    var currentVC : UIViewController?
    var previousVC : UIViewController?
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
}

extension AppScreens {
    func navigateToMapViewVC(_ countryData : CountryResponse) {
        let vc = MapViewController.init()
        vc.countryData = countryData
        currentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func backToHomeVC() {
        currentVC?.navigationController?.popViewController(animated: true)
    }
}
