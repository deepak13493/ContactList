//
//  ContactRequestResponseHandler.swift
//  ContactList
//
//  Created by Deepak Sharma on 05/12/17.
//  Copyright © 2017 Deepak Sharma. All rights reserved.
//

import UIKit

typealias ContactsClosure = (([Contact]?) -> Void)

struct ContactRequestResponseHandler: APIHandlerDelegate {
    
    var contactsDataClosure: ContactsClosure?
    
    let apiManager = APIHandler()
    
    mutating func fetchContacts(_ formUrl: String? , parsedContacts:  @escaping ContactsClosure)  {
        guard let formUrl = formUrl else { 
            return
        }
        contactsDataClosure = parsedContacts
        apiManager.delegate = self
        apiManager.request(formUrl)
        
    }
    
    //MARK:- APIHandlerDelegate delegate method
    func response(_ data: Data?, error: Error?) {
        
        guard let data = data else {
            contactsDataClosure?(nil)
            return
        }
        var contactDataParser = ContactDataParser()
        let contacts = contactDataParser.parse(data)
        contactsDataClosure?(contacts)

    }
}
