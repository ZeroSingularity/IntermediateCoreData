//
//  EmployeesController.swift
//  IntermediateCoreData
//
//  Created by Jacobo Hernandez on 12/13/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import UIKit

class EmployeesController: UITableViewController {
    var company: Company?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = company?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkBlue
        setupPlusButtonInNavBar(selector: #selector(handleAdd))
    }
    
    @objc private func handleAdd() {
        let createEmployeeController = CreateEmployeeController()
        let navController = CustomNavigationController(rootViewController: createEmployeeController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
}
