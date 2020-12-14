//
//  CreateEmployeeController.swift
//  IntermediateCoreData
//
//  Created by Jacobo Hernandez on 12/13/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import UIKit

class CreateEmployeeController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkBlue
        navigationItem.title = "Create Employee"
        setupCancelButtonInNavBar()
    }
}
