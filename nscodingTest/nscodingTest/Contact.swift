//
//  Contact.swift
//  nscodingTest
//
//  Created by Paulo Jose on 08/08/18.
//  Copyright © 2018 Paulo Jose. All rights reserved.
//

import Foundation

class Contact: NSObject, NSCoding {
    
    static var DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static var ArchiveURL = DocumentsDirectory.appendingPathComponent("contact")
    
    let name: String
    let phone: String
    
    init(name: String, phone: String) {
        self.name = name
        self.phone = phone
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: "name") as? String else {
            return nil
        }
        
        let phone = aDecoder.decodeObject(forKey: "phone") as? String
        
        self.init(name: name, phone: phone!)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(phone, forKey: "phone")
    }
    
}
