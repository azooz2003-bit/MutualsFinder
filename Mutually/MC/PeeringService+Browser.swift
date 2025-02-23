//
//  PeeringService+Browser.swift
//  Mutually
//
//  Created by Abdulaziz Albahar on 1/28/25.
//

import MultipeerConnectivity

extension PeeringService: MCNearbyServiceBrowserDelegate {
    func sendInvite(for peer: Peer) {
        browser
            .invitePeer(
                peer.peerID,
                to: session,
                withContext: self.name.data(using: .utf8),
                timeout: 60
            )
    }

    func cancelInvite(to peer: Peer) {
        discoveredPeers.removeValue(forKey: peer)
    }

    func browser(
        _ browser: MCNearbyServiceBrowser,
        foundPeer peerID: MCPeerID,
        withDiscoveryInfo info: [String : String]?
    ) {
        guard let peer = Peer.make(peerID: peerID, data: info) else { return }

        discoveredPeers[peer] = .discovered
    }

    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        guard let peer = discoveredPeers.first(where: { $0.key.peerID == peerID })?.key else {
            return
        }
        self.discoveredPeers.removeValue(forKey: peer)
    }

    func browser(
        _ browser: MCNearbyServiceBrowser,
        didNotStartBrowsingForPeers error: any Error
    ) {

    }


}
