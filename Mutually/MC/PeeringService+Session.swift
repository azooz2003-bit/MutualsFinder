//
//  PeeringService+Session.swift
//  Mutually
//
//  Created by Abdulaziz Albahar on 1/28/25.
//

import MultipeerConnectivity

extension PeeringService: MCSessionDelegate {

    func session(
        _ session: MCSession,
        peer peerID: MCPeerID,
        didChange state: MCSessionState
    ) {
        switch state {
        case .notConnected:
            print("\(peerID.displayName) disconnected")
        case .connecting:
            print("\(peerID.displayName) connecting")
        case .connected:
            print("\(peerID.displayName) connected")
        @unknown default:
            print("Unknown state in session")
        }
    }

    func session(
        _ session: MCSession,
        didReceive stream: InputStream,
        withName streamName: String,
        fromPeer peerID: MCPeerID
    ) {

    }

    func session(
        _ session: MCSession,
        didReceive data: Data,
        fromPeer peerID: MCPeerID
    ) {

    }

    func session(
        _ session: MCSession,
        didStartReceivingResourceWithName resourceName: String,
        fromPeer peerID: MCPeerID,
        with progress: Progress
    ) {

    }

    func session(
        _ session: MCSession,
        didFinishReceivingResourceWithName resourceName: String,
        fromPeer peerID: MCPeerID,
        at localURL: URL?,
        withError error: (any Error)?
    ) {
        
    }

}
