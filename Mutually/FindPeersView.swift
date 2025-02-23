//
//  FindPeersView.swift
//  Mutually
//
//  Created by Abdulaziz Albahar on 1/25/25.
//

import SwiftUI

struct FindPeersView: View {
    @Environment(PeeringService.self) var peeringService
    @Environment(ContactService.self) var contactService

    var body: some View {
        List {
            discoveredSection
            Spacer(minLength: 40)
            receivedSection
            Spacer(minLength: 40)
            contactsSection
        }
        .accessibilityLabel("Find Peers")
        .accessibilityHint("Pull down to refresh and discover new peers")
        .refreshable {
            peeringService.restart()
            peeringService.startAdvertising()
            peeringService.startBrowsing()
            await fetchContacts()
        }
        .task {
            peeringService.startAdvertising()
            peeringService.startBrowsing()
            await fetchContacts()
        }
    }

    var discoveredSection: some View {
        Section {
            ForEach(Array(peeringService.discoveredPeers), id: \.key.id) { (peer, state) in
                peerCell(for: peer, state: state)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Peer \(peer.name)")
                    .accessibilityValue(state.display)
                    .accessibilityHint("Tap to request an exchange from this peer")
            }
        } header: {
            Text("Discovered")
                .accessibilityAddTraits(.isHeader)
        }
    }

    var receivedSection: some View {
        Section {
            ForEach(peeringService.receivedInvites, id: \.id) { session in
                peerCell(for: session.peer, state: nil)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Invitation from \(session.peer.name)")
                    .accessibilityHint("Double tap to respond to invitation")
            }
        } header: {
            Text("Received")
                .accessibilityAddTraits(.isHeader)
        }
    }

    var contactsSection: some View {
        Section {
            ForEach(contactService.contacts, id: \.id) { contact in
                contactCell(for: contact)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel(contact.name)
                    .accessibilityValue(contact.info.display)
                    .accessibilityHint("Contact information")
            }
        } header: {
            HStack {
                Text("Contacts")
                Spacer()
                Text("Count: \(contactService.contacts.count)")
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Contacts section, \(contactService.contacts.count) contacts")
            .accessibilityAddTraits(.isHeader)
        }
    }

    func peerCell(for peer: Peer, state: ConnectionState?) -> some View {
        HStack {
            Text(peer.name)
            Spacer()
            Text(state?.display ?? "")
        }
    }

    func contactCell(for contact: Contact) -> some View {
        HStack {
            Text(contact.name)
            Spacer()
            Text(contact.info.display)
        }
    }

    func fetchContacts() async {
        do {
            try await contactService.fetchContacts()
        } catch {
            print("Failed to fetch contacts: \(error)")
        }
    }
}

#Preview {
    FindPeersView()
}
