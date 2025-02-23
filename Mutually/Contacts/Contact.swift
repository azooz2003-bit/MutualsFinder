//
//  Contact.swift
//  Mutually
//
//  Created by Abdulaziz Albahar on 1/26/25.
//

import Contacts

struct Contact: Codable, Identifiable {
    let id: UUID
    let name: String
    let info: Info

    init(name: String, info: Info) {
        id = UUID()
        self.name = name
        self.info = info
    }

    enum Info: Codable {
        case email(String), phone(String)

        var display: String {
            switch self {
            case .email(let email):
                return email
            case .phone(let phone):
                return phone
            }
        }
    }

    static func make(_ contact: CNContact) -> [Self] {
        let emailContacts = contact.emailAddresses.map {
            Contact(
                name: contact.givenName + " " + contact.familyName,
                info: .email($0.value as String)
            )
        }

        let phoneContacts = contact.phoneNumbers.map {
            Contact(
                name: contact.givenName + " " + contact.familyName,
                info: .phone($0.value.stringValue)
            )
        }

        return emailContacts + phoneContacts
    }
}
