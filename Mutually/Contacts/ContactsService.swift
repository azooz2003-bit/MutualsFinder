//
//  ContactsService.swift
//  Mutually
//
//  Created by Abdulaziz Albahar on 1/28/25.
//

import Contacts

@Observable
class ContactService {
    let contactStore = CNContactStore()

    var contacts: [Contact] = []

    func requestAccess() async throws -> Bool {
        let accessGranted = try await contactStore.requestAccess(for: .contacts)

        guard accessGranted else {
            print("Could not access contact store.")
            return false
        }

        return true
    }

    func fetchContacts() async throws {
        let keys = [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey
        ] as [CNKeyDescriptor]

        let request = CNContactFetchRequest(keysToFetch: keys)

        var contacts = [Contact]()
        try contactStore.enumerateContacts(with: request) { contact, match in
            guard !match.pointee.boolValue else {
                print("Something wrong happened fetching \(contact.givenName)")
                return
            }
            contacts += Contact.make(contact)
        }

        self.contacts = contacts
    }
}
