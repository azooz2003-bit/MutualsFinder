//
//  PeeringService+Advertiser.swift
//  Mutually
//
//  Created by Abdulaziz Albahar on 1/28/25.
//

import MultipeerConnectivity

extension PeeringService: MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(
        _ advertiser: MCNearbyServiceAdvertiser,
        didReceiveInvitationFromPeer peerID: MCPeerID,
        withContext context: Data?,
        invitationHandler: @escaping (Bool, MCSession?) -> Void
    ) {
        guard let session = Session.make(
            peerID: peerID,
            data: context,
            invitationHandler: invitationHandler
        ) else {
            print("Failed to create session")
            return
        }

        self.receivedInvites.append(session)
    }


    func advertiser(
        _ advertiser: MCNearbyServiceAdvertiser,
        didNotStartAdvertisingPeer error: any Error
    ) {
        // TODO: prop error
    }

}
