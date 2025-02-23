////
////  BluetoothService+Peripheral.swift
////  Mutually
////
////  Created by Abdulaziz Albahar on 1/26/25.
////
//
//import CoreBluetooth
//import UIKit
//
//// All callbacks are on `main`
//extension BluetoothService: CBPeripheralManagerDelegate {
//
//    func startAdvertising(
//        as name: String = "IDK",
//        _ peripheral: CBPeripheralManager
//    ) {
//        guard peripheral.state == .poweredOn else { return }
//
//        peripheral.add(Self.service)
//        print(Self.service)
//
//        let data = [ CBAdvertisementDataLocalNameKey : name]
//        peripheral.startAdvertising(data)
//        isAdvertising = true
//    }
//
//    private func interestedPeer(for id: UUID) -> Peer? {
//        interestedPeers.first(where: { $0.id == id })
//    }
//
//    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
//        startAdvertising(as: name, peripheral)
//        print("Peripheral state: \(peripheral.state)")
//    }
//
//    func peripheralManager(
//        _ peripheral: CBPeripheralManager,
//        didAdd service: CBService,
//        error: (any Error)?
//    ) {
//        // Connection made
//    }
//
//    func peripheralManager(
//        _ peripheral: CBPeripheralManager,
//        didReceiveWrite requests: [CBATTRequest]
//    ) {
//        for request in requests {
//            let central = request.central
//            guard let value = request.value, let type = MessageType(rawValue: request.characteristic.uuid.uuidString) else {
//                return
//            }
//
//            switch type {
//            case .name:
//                guard let name = String(data: value, encoding: .utf8) else {
//                    break
//                }
//
//                self.interestedPeers
//                    .insert(
//                        Peer(
//                            name: name,
//                            connection: .central(central)
//                        )
//                    )
//            case .contacts:
//                guard let contacts = try? JSONDecoder().decode([Contact].self, from: value),
//                      let peer = interestedPeer(for: central.identifier) else {
//                    break
//                }
//
//                contactsListener(peer, contacts)
//            }
//        }
//    }
//
//    func peripheralManagerDidStartAdvertising(
//        _ peripheral: CBPeripheralManager,
//        error: (any Error)?
//    ) {
//        if let error {
//            advertisingFailure(error)
//            return
//        }
//    }
//
//}
