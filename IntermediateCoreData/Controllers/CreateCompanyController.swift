//
//  CreateCompanyController.swift
//  IntermediateCoreData
//
//  Created by Jacobo Hernandez on 9/23/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import UIKit
import CoreData

protocol CreateCompanyControllerDelegate {
    func didAddCompany(company: Company)
    func didEditCompany(company: Company)
}

class CreateCompanyController: UIViewController {
    var delegate: CreateCompanyControllerDelegate?
    var company: Company? {
        didSet {
            nameTextField.text = company?.name
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        //enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = company == nil ? "Create Company" : "Edit Company"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        view.backgroundColor = UIColor.darkBlue
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    private func setupUI() {
            let lightBlueBackgroundView = UIView()
            lightBlueBackgroundView.backgroundColor = UIColor.lightBlue
            lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(lightBlueBackgroundView)
            
        lightBlueBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            lightBlueBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            lightBlueBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            
            view.addSubview(nameLabel)
            nameLabel.topAnchor.constraint(equalTo: lightBlueBackgroundView.topAnchor).isActive = true
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
            
            
            nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
            
    //        nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            view.addSubview(nameTextField)
            nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
            nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
            nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
            
        }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleSave() {
        if company == nil {
            createCompany()
        } else {
            saveCompanyChanges()
        }
    }
    
    private func createCompany() {
        // initialization of core data stack
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(nameTextField.text, forKey: "name")
        
        //perform the save
        do {
            try context.save()
            dismiss(animated: true) {
                self.delegate?.didAddCompany(company: company as! Company)
            }
            
        } catch let saveErr {
            print("Failed to save company:", saveErr)
        }
    }
    
    private func saveCompanyChanges() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        company?.name = nameTextField.text
        
        do {
            try context.save()
            dismiss(animated: true) {
                self.delegate?.didEditCompany(company: self.company!)
            }
        } catch let saveErr {
            print("Failed to save company changes:", saveErr)
        }
    }
}
