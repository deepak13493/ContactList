//
//  ContactDataParser.swift
//  ContactList
//
//  Created by Deepak Sharma on 05/12/17.
//  Copyright © 2017 Deepak Sharma. All rights reserved.
//

import Foundation
// parse json data
struct ContactDataParser {
    
    var contacts: [Contact]?
    
    mutating func parse(_ forData: Data) -> [Contact]? {
        
        do {
            guard let parsedObjects = try JSONSerialization.jsonObject(with: forData, options: []) as? [[String: AnyObject]] else {
                return nil
            }
            
            contacts = parsedObjects.map({ (parsedObject) -> Contact in
                parseContactInfo(parsedObject)
            })
           
        } catch let error as NSError {
            print(error.description)
        }
        
        return contacts
    }
    
    
    //MARK:- parser method
    private func parseContactInfo(_ contactDictionary: [String: AnyObject]) -> Contact {
        return Contact(id: contactDictionary["id"] as? Int64,
                       name: contactDictionary["name"] as? String,
                       username: contactDictionary["username"] as? String,
                       email: contactDictionary["email"] as? String,
                       phone: contactDictionary["phone"] as? String,
                       website: contactDictionary["website"] as? String,
                       address: parseAddressInfo(contactDictionary["address"] as? [String:AnyObject]),
                       company: parseCompanyInfo(contactDictionary["company"] as? [String:AnyObject]))
    }
    
    
    private func parseAddressInfo(_ addressDictionary: [String: AnyObject]?) -> Address? {
        
        //parse geo information
        func parseGeoInfo(_ geoDictionary: [String : AnyObject]?) -> Geo? {
            guard let geoDictionary = geoDictionary else {
                return nil
            }
            return Geo(lat: geoDictionary["lat"] as? String,
                       lng: geoDictionary["lng"] as? String)
        }
        
        //parse address information
        guard let addressDictionary = addressDictionary else {
            return nil
        }
        
        return Address(street: addressDictionary["street"] as? String,
                       suite: addressDictionary["suite"] as? String,
                       city: addressDictionary["city"] as? String,
                       zipcode: addressDictionary["zipcode"] as? String,
                       geo: parseGeoInfo(addressDictionary["geo"] as? [String:AnyObject]))
        
    }
    
    
    //parse comapny information
    private func parseCompanyInfo(_ companyDictionary: [String: AnyObject]?) -> Company? {
        guard let companyDictionary = companyDictionary else {
            return nil
        }
        
        return Company(name: companyDictionary["name"] as? String,
                       catchPhrase: companyDictionary["catchPhrase"] as? String,
                       bs: companyDictionary["bs"] as? String)
    }

    
}
