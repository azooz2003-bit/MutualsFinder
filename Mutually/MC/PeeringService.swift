//
//  PeeringService.swift
//  Mutually
//
//  Created by Abdulaziz Albahar on 1/28/25.
//

import MultipeerConnectivity
import UIKit

@Observable
class PeeringService: NSObject {
    static let serviceType = "mutually"

    // User
    let id = UUID()
    var name = "Jason" { // TODO: change when search UI is done
        didSet {
            guard !name.isEmpty else { return }
            self.peerID = MCPeerID(displayName: name)
        }
    }
    private var peerID: MCPeerID = MCPeerID(displayName: UIDevice.current.name)

    // Managers
    var advertiser: MCNearbyServiceAdvertiser!
    var browser: MCNearbyServiceBrowser!
    var session: MCSession!

    // Peering updates
    var discoveredPeers = [Peer : ConnectionState]()
    var receivedInvites = [Session]()
    var activePeer: Peer?

    override init() {
        super.init()
        setupSession()
    }

    // MARK: Session Setup

    private func setupSession() {
        session = MCSession(peer: peerID)
        session.delegate = self

        browser = MCNearbyServiceBrowser(
            peer: peerID,
            serviceType: Self.serviceType
        )
        browser.delegate = self

        advertiser = MCNearbyServiceAdvertiser(
            peer: peerID,
            discoveryInfo: ["name" : name, "id" : id.uuidString],
            serviceType: Self.serviceType
        )
        advertiser.delegate = self
    }

    func teardown() {
        advertiser.stopAdvertisingPeer()
        advertiser.delegate = nil
        advertiser = nil
        browser.stopBrowsingForPeers()
        browser.delegate = nil
        browser = nil
        session.disconnect()
        session.delegate = nil
        session = nil

        discoveredPeers = [:]
        receivedInvites = []
        activePeer = nil
    }


    func restart() {
        teardown()
        setupSession()
    }

    // MARK: Browsing

    func startBrowsing() {
        browser.startBrowsingForPeers()
    }


    func stopBrowsing() {
        browser.stopBrowsingForPeers()
    }

    // MARK: Advertising

    func startAdvertising() {
        advertiser.startAdvertisingPeer()
    }

    func stopAdvertising() {
        advertiser.stopAdvertisingPeer()
    }

}
