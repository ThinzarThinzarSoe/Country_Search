//
//  UINavigationController + Extension.swift
//  Code_Test
//
//  Created by Thinzar Soe on 9/8/22.
//

import UIKit

extension UINavigationController {

  public func pushViewController(viewController: UIViewController,
                                 animated: Bool,
                                 completion: (() -> Void)?) {
    CATransaction.begin()
    CATransaction.setCompletionBlock(completion)
    pushViewController(viewController, animated: animated)
    CATransaction.commit()
  }

    var isHiddenUnderline: Bool {
        get {
            guard let hairline = findUnderlineImageView(navigationBar) else { return true }
            return hairline.isHidden
        }
        set {
            if let hairline = findUnderlineImageView(navigationBar) {
                hairline.isHidden = newValue
            }
        }
    }

    private func findUnderlineImageView(_ view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        }

        for subview in view.subviews {
            if let imageView = self.findUnderlineImageView(subview) {
                return imageView
            }
        }

        return nil
    }
}

