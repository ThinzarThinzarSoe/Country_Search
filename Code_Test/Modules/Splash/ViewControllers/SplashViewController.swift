//
//  SplashViewController.swift
//  Code_Test
//
//  Created by Thinzar Soe on 9/8/22.
//

import UIKit

class SplashViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {[unowned self] in
            gotoHomeViewController()
        }
    }
    
    private func gotoHomeViewController(){
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let viewController = HomeViewController.init()
        let navigation = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
