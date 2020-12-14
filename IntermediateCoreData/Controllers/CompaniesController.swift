//
//  ViewController.swift
//  IntermediateCoreData
//
//  Created by Jacobo Hernandez on 9/22/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController {
    var companies = [Company]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.companies = CoreDataManager.shared.fetchCompanies()
        tableView.backgroundColor = .darkBlue
        tableView.separatorColor = .white
        tableView.register(CompanyCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableFooterView = UIView()
        
        navigationItem.title = "Companies"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
        setupPlusButtonInNavBar(selector: #selector(handleAddCompany))
    }
    
    @objc private func handleReset() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        
        do {
            try context.execute(batchDeleteRequest)
            var indexPathstoRemove = [IndexPath]()
            for (index, _) in companies.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                indexPathstoRemove.append(indexPath)
            }
            
            companies.removeAll()
            tableView.deleteRows(at: indexPathstoRemove, with: .fade)
        } catch let delErr {
            print("Failed to delete companies:", delErr)
        }
    }
    
    @objc private func handleAddCompany() {
        let createCompanyController = CreateCompanyController()
        let navController = CustomNavigationController(rootViewController: createCompanyController)
        navController.modalPresentationStyle = .fullScreen
        createCompanyController.delegate = self
        present(navController, animated: true, completion: nil)
    }
}
