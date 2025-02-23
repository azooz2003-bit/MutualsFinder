////
////  BluetoothService+Central.swift
////  Mutually
////
////  Created by Abdulaziz Albahar on 1/26/25.
////
//
//import CoreBluetooth
//import UIKit
//
//// All callbacks are on `main`
//extension BluetoothService: CBCentralManagerDelegate {
//
//    private func discoveredPeer(for id: UUID) -> Peer? {
//        discoveredPeers.first(where: { $0.key.id == id })?.key
//    }
//
//    private func addDiscoveredPeer(_ peer: Peer) {
//        updatePeerState(peer, to: .discovered)
//    }
//
//    private func updatePeerState(_ peer: Peer, to state: ConnectionState) {
//        guard case let .peripheral(receiver) = peer.connection else { return }
//
//        switch state {
//        case .connected:
//            // TODO: use input name instead
//            guard let nameData = "IDK".data(using: .utf8) else {
//                break
//            }
//            receiver
//                .writeValue(
//                    nameData,
//                    for: .name,
//                    type: .withoutResponse
//                )
//        default: break
//        }
//        discoveredPeers[peer] = state
//    }
//
//    func startScanning(_ central: CBCentralManager) {
//        guard central.state == .poweredOn else { return }
//
//        central.scanForPeripherals(withServices: nil /*[Self.service.uuid]*/) // TODO: use service
//        print(Self.service.uuid)
//    }
//
//    /**
//     {
//
//         case unknown = 0
//
//         case resetting = 1
//
//         case unsupported = 2
//
//         case unauthorized = 3
//
//         case poweredOff = 4
//
//         case poweredOn = 5
//     }
//     */
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        startScanning(central)
//        print("Central state: \(central.state)")
//    }
//
//    func centralManager(
//        _ central: CBCentralManager,
//        didDiscover peripheral: CBPeripheral,
//        advertisementData: [String : Any],
//        rssi RSSI: NSNumber
//    ) {
//        guard let name = advertisementData[CBAdvertisementDataLocalNameKey] as? String else { return }
//
//        let peer = Peer(name: name, connection: .peripheral(peripheral))
//        self.addDiscoveredPeer(peer)
//    }
//
//    func centralManager(
//        _ central: CBCentralManager,
//        didConnect peripheral: CBPeripheral
//    ) {
//        guard let peer = discoveredPeers
//            .first(where: { $0.key.id == peripheral.identifier })?.key else {
//            return
//        }
//        updatePeerState(peer, to: .connected)
//    }
//
//    func centralManager(
//        _ central: CBCentralManager,
//        didFailToConnect peripheral: CBPeripheral,
//        error: (any Error)?
//    ) {
//        guard let peer = discoveredPeers
//            .first(where: { $0.key.id == peripheral.identifier })?.key else {
//            return
//        }
//        updatePeerState(peer, to: .failed(error))
//    }
//
//}
