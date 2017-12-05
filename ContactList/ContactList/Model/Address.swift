//
//  Address.swift
//  ContactList
//
//  Created by Deepak Sharma on 05/12/17.
//  Copyright © 2017 Deepak Sharma. All rights reserved.
//

import Foundation

struct Address  {
    let street : String?
    let suite : String?
    let city: String?
    let zipcode: String?
    let geo: Geo?
}

struct Geo {
    let lat: String?
    let lng: String?
}
