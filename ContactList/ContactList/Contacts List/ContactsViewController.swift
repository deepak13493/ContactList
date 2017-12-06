//
//  ContactsViewController.swift
//  ContactList
//
//  Created by Deepak Sharma on 05/12/17.
//  Copyright © 2017 Deepak Sharma. All rights reserved.
//

import UIKit

struct URLConstant {
    static let apiPath = "http://jsonplaceholder.typicode.com/users"
}

class ContactsViewController: BaseViewController {
    
    //MARK:- property
    var contacts = [Contact]()
    
    //MARK:- private IBOutlets
    @IBOutlet private weak var contactsTableView: UITableView!
    @IBOutlet private weak var ascendingButton: UIButton!
    @IBOutlet private weak var descendingButton: UIButton!
    
    //MARK:- view controller life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var contactRequestResponseHandler = ContactRequestResponseHandler()
        contactsTableView.tableFooterView = UIView()
        showActivityView()
        DispatchQueue.global(qos: .background).async { [weak self] in
                        
            contactRequestResponseHandler.fetchContacts(URLConstant.apiPath) { [weak self] (contacts) in
                
                DispatchQueue.main.async {
                    
                    if let contacts = contacts {
                        self?.contacts = contacts
                        self?.selectAscending()
                    } else {
                        let alert = UIAlertController(title: "Alert", message: "Please check your Network", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                        }))
                        self?.present(alert, animated: true, completion: nil)
                    }
                    self?.hideActivityView()
                    
                }
                
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- IBActions
    
    @IBAction func ascending(_ sender: Any) {
        self.selectAscending()
    }
    
    @IBAction func descending(_ sender: Any) {
        self.selectDescending()
    }
    
    //MARK:- private helper method
    private func selectAscending() {
        descendingButton.titleLabel?.textColor = UIColor.gray
        contacts.sort(by: {
            guard let name = $0.name, let name1 = $1.name else { return false }
            return name < name1
        })
        contactsTableView.reloadData()
        
    }
    
    private func selectDescending() {
        ascendingButton.titleLabel?.textColor = UIColor.gray
        contacts.sort(by: {
            guard let name = $0.name, let name1 = $1.name else { return false }
            return name > name1
        })
        contactsTableView.reloadData()
    }
    
}


extension ContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let contactTableViewCell =  tableView.dequeueReusableCell(withIdentifier: String(describing: ContactTableViewCell.self), for: indexPath) as! ContactTableViewCell
        let contact = contacts[indexPath.row]
        contactTableViewCell.configure(cell: contact.name, email: contact.email)
        
        return contactTableViewCell
    }
    
    
}

extension ContactsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
