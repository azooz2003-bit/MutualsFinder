//
//  Session.swift
//  Mutually
//
//  Created by Abdulaziz Albahar on 1/28/25.
//

import MultipeerConnectivity

struct Session: Identifiable {

    var id: UUID {
        peer.id
    }
    let peer: Peer
    let invitationHandler: ((Bool, MCSession?) -> Void)

    static func make(
        peerID: MCPeerID,
        data: Data?,
        invitationHandler: @escaping (
            (Bool, MCSession?) -> Void
        )
    ) -> Self? {
        guard let peer = Peer.make(peerID: peerID, data: data) else {
            return nil
        }

        return Session(peer: peer, invitationHandler: invitationHandler)
    }

    static func == (lhs: Session, rhs: Session) -> Bool {
        lhs.id == rhs.id
    }
}
