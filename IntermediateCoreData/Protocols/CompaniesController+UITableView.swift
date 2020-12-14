//
//  CompaniesController+UITableView.swift
//  IntermediateCoreData
//
//  Created by Jacobo Hernandez on 11/12/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import UIKit

extension CompaniesController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .lightBlue
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "No companies available..."
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return companies.count == 0 ? 150 : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CompanyCell
        let company = companies[indexPath.row]
        cell.company = company
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteItem = UIContextualAction(style: .destructive, title: "delete") { (action, view, bool) in
            let company = self.companies[indexPath.row]
            self.companies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(company)
            do {
                try context.save()
            }catch let saveErr {
                print("failed to delete company", saveErr)
            }
        }
        
        let editItem = UIContextualAction(style: .normal, title: "Edit") { (action, view, bool) in
            print("edit")
            let editCompanyController = CreateCompanyController()
            editCompanyController.company = self.companies[indexPath.row]
            editCompanyController.delegate = self
            let navController = CustomNavigationController(rootViewController: editCompanyController)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
        
        deleteItem.backgroundColor = .lightRed
        editItem.backgroundColor = .darkBlue
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteItem, editItem])
        return swipeAction
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let employeesController = EmployeesController()
        let company = companies[indexPath.row]
        employeesController.company = company
        navigationController?.pushViewController(employeesController, animated: true)
    }
}
