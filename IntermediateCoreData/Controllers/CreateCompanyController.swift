//
//  CreateCompanyController.swift
//  IntermediateCoreData
//
//  Created by Jacobo Hernandez on 9/23/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import UIKit

class CreateCompanyController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.darkBlue
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
}
