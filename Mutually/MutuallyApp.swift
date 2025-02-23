//
//  MutuallyApp.swift
//  Mutually
//
//  Created by Abdulaziz Albahar on 1/25/25.
//

import SwiftUI

@main
struct MutuallyApp: App {
    @State var peeringService: PeeringService
    @State var contactService: ContactService

    init() {
        self._peeringService = State(initialValue:  PeeringService())
        self._contactService = State(initialValue: ContactService())
    }

    var body: some Scene {
        WindowGroup {
            FindPeersView()
                .environment(peeringService)
                .environment(contactService)
        }
    }
}
