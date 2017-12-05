//
//  ContactsViewController.swift
//  ContactList
//
//  Created by Deepak Sharma on 05/12/17.
//  Copyright © 2017 Deepak Sharma. All rights reserved.
//

import UIKit

struct URLConstant {
    static let apiPath = "http://jsonplaceholder.typicode.com/userss"
}

class ContactsViewController: BaseViewController {
    
    var contacts = [Contact]()
    @IBOutlet weak var contactsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var contactRequestResponseHandler = ContactRequestResponseHandler()

        showActivityView()
        DispatchQueue.global(qos: .background).async { [weak self] in
                        
            contactRequestResponseHandler.fetchContacts(URLConstant.apiPath) { [weak self] (contacts) in
                
                DispatchQueue.main.async {
                    
                    if let contacts = contacts {
                        self?.contacts = contacts
                        self?.contactsTableView.reloadData()
                        
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
        
    }
    
    @IBAction func descending(_ sender: Any) {
        
    }
    
}


extension ContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let contactTableViewCell =  tableView.dequeueReusableCell(withIdentifier: String(describing: ContactTableViewCell.self), for: indexPath) as! ContactTableViewCell
        //issueTableViewCell.configureCell(issues?[indexPath.row].title, details: issues?[indexPath.row].details)
        
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
