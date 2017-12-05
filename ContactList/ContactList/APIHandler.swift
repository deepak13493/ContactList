//
//  APIHandler.swift
//  ContactList
//
//  Created by Deepak Sharma on 05/12/17.
//  Copyright © 2017 Deepak Sharma. All rights reserved.
//

import Foundation

protocol APIHandlerDelegate {
    func response(_ data: Data?, error: Error?)
}

class APIHandler {
    
    var delegate: APIHandlerDelegate?
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    func request(_ urlString: String!) {
        
        let url = URL (string: urlString)
        let request = URLRequest(url: url!)
        
        let task = session.dataTask(with: request) { (data: Data?, reponse: URLResponse?, error: Error?) in
            
            //not used response - used to check http status error
            
            if let data = data {
                self.delegate?.response(data as Data?, error: nil)
            } else {
                self.delegate?.response(nil, error: error)
            }
        }
        task.resume()
        
    }
}
