//
//  ContactDetailsViewController.swift
//  ContactList
//
//  Created by Deepak Sharma on 06.12.17.
//  Copyright © 2017 Deepak Sharma. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {

    var selectedContact: Contact?
    
    @IBOutlet private weak var contactDetailsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contactDetailsLabel.attributedText = self.contactDetailsText()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* use label with attributed string for demo purpose*/
    private func contactDetailsText() -> NSAttributedString {
        
        let contactDetailsString = NSMutableAttributedString()
        
        contactDetailsString.append(self.attributeText(key: "Id", value: String(selectedContact?.id ?? 0)) ?? NSMutableAttributedString())
        contactDetailsString.append(self.attributeText(key: "Name", value: selectedContact?.name) ?? NSMutableAttributedString())
        contactDetailsString.append(self.attributeText(key: "User Name", value: selectedContact?.username) ?? NSMutableAttributedString())
        contactDetailsString.append(self.attributeText(key: "Email", value: selectedContact?.email) ?? NSMutableAttributedString())
        contactDetailsString.append(self.attributeText(key: "Phone Number", value: selectedContact?.phone) ?? NSMutableAttributedString())
        contactDetailsString.append(self.attributeText(key: "Website", value: selectedContact?.website) ?? NSMutableAttributedString())
        contactDetailsString.append(self.attributeText(key: "Address", value: self.formattedAddress()) ?? NSMutableAttributedString())
        contactDetailsString.append(self.attributeText(key: "Geo Location", value: self.formattedGeoLocation()) ?? NSMutableAttributedString())

        contactDetailsString.append(self.attributeText(key: "Company", value: self.formattedCompany()) ?? NSMutableAttributedString())

        return contactDetailsString
    }
    
    private func attributeText(key: String?, value: String?) -> NSMutableAttributedString? {
        guard let key = key, let value = value else {
            return nil
        }
        let keyAttribute = [ NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17.0)]
        let valueAttribute = [ NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0)]
        
        let attributedString = NSMutableAttributedString()
        let keyString = NSMutableAttributedString(string: key, attributes: keyAttribute)
        let valueString = NSMutableAttributedString(string: value, attributes: valueAttribute)
        
        attributedString.append(keyString)
        attributedString.append(NSMutableAttributedString(string:" : "))
        attributedString.append(valueString)
        attributedString.append(NSMutableAttributedString(string:"\n\n"))
        return attributedString


    }
    
    private func formattedAddress() -> String {
        
        let street = String(selectedContact?.address?.street ?? "") + ","
        let suite = String(selectedContact?.address?.suite ?? "") + ","
        let city = String(selectedContact?.address?.city ?? "") + ","
        let zipcode = String(selectedContact?.address?.zipcode ?? "") + ","
        

        return street + suite + city + zipcode 
        
    }
    
    private func formattedCompany() -> String {
    
        let name = String(selectedContact?.company?.name ?? "") + ","
        let catchPhrase = String(selectedContact?.company?.catchPhrase ?? "") + ","
        let bs = String(selectedContact?.company?.bs ?? "")
        return name + catchPhrase + bs
        
    }

    func formattedGeoLocation() -> String {
        let lat = String(selectedContact?.address?.geo?.lat ?? "") + ","
        let lng = String(selectedContact?.address?.geo?.lng ?? "")
          return  lat + lng
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
