//
//  ViewController.swift
//  nscodingTest
//
//  Created by Paulo Jose on 08/08/18.
//  Copyright © 2018 Paulo Jose. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var contacts = [Contact]()

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        contacts = loadContacts() ?? [Contact]()
        
        tableView.tableFooterView = nil
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapAdicionar(_ sender: Any) {
        if nameTextField.text != "" && phoneTextField.text != "" {
            
            let contact = Contact(name: nameTextField.text ?? "", phone: phoneTextField.text ?? "")
            contacts.append(contact)
            saveContacts(contacts: contacts)
            tableView.reloadData()
            
            nameTextField.text = ""
            phoneTextField.text = ""
            
            self.view.endEditing(true)
            
            let alert = UIAlertController(title: "Contato salvo", message: "O Contato foi salvo na agenda", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            
            
            
        } else {
            
            let alert = UIAlertController(title: "Você esqueceu de preencher algum campo", message: "Preencha todos os campos para adicionar o contato na agenda", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
        
    }
    
    func loadContacts() -> [Contact]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Contact.ArchiveURL.path) as? [Contact]
    }
    
    func saveContacts(contacts: [Contact]) {
        
        let isSucefull = NSKeyedArchiver.archiveRootObject(contacts, toFile: Contact.ArchiveURL.path)
        
        if !isSucefull {
            
            let alert = UIAlertController(title: "Não foi possível salvar a lista de contato", message: "Houve um erro enquanto a lista de contatos era salva", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        } else {

            
        }
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as? ContactTableViewCell
        cell?.nameLabel.text  = contacts[indexPath.row].name
        cell?.phoneLabel.text = contacts[indexPath.row].phone
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
            saveContacts(contacts: contacts)
        }
        
    }
    
}

