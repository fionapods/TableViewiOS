//
//  PlistLoader.swift
//  Contacts
//
//  Created by Fiona Podrima on 3/10/18.
//  Copyright © 2018 Cacttus Education. All rights reserved.
//

import Foundation

enum PlistError: Error {
    case invalidResource
    case parsingFailure
}

class PlistLoader {
    static func array(fromFile name: String, ofType type: String) throws -> [[String: String]] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw PlistError.invalidResource
        }
        
        guard let array = NSArray(contentsOfFile: path) as? [[String: String]] else {
            throw PlistError.parsingFailure
        }
        
        return array
    }
}

class ContactsSource {
    static var contacts: [Contact] {
        let data = try! PlistLoader.array(fromFile: "ContactsDB", ofType: "plist")
        return data.flatMap { Contact(dictionary: $0) }
    }
    
}
