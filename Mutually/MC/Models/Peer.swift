//
//  DiscoveredPeer.swift
//  Mutually
//
//  Created by Abdulaziz Albahar on 1/26/25.
//

import MultipeerConnectivity

struct Peer: Hashable, Identifiable {

    let id: UUID
    let peerID: MCPeerID
    let name: String

    static func make(peerID: MCPeerID, data: [String : String]?) -> Self? {
        guard let data, let name = data["name"], let id = data["id"], let uuid = UUID(uuidString: id) else {
            return nil
        }

        return Peer(id: uuid, peerID: peerID, name: name)
    }

    static func make(peerID: MCPeerID, data: Data?) -> Self? {
        guard let data, let info = try? JSONDecoder().decode(
            [String : String].self,
            from: data
        ), let name = info["name"], let id = info["id"], let uuid = UUID(uuidString: id) else {
            return nil
        }

        return Peer(id: uuid, peerID: peerID, name: name)
    }
}



