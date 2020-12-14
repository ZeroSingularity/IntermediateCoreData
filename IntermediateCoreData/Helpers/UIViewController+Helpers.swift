//
//  UIViewController+Helpers.swift
//  IntermediateCoreData
//
//  Created by Jacobo Hernandez on 12/13/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupPlusButtonInNavBar(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: selector)
    }
    
    func setupCancelButtonInNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelModel))
    }
    
    @objc func handleCancelModel() {
        dismiss(animated: true, completion: nil)
    }
}
