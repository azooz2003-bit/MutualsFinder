////
////  BluetoothService.swift
////  Mutually
////
////  Created by Abdulaziz Albahar on 1/26/25.
////
//
////import CoreBluetooth
//
//@Observable
//class BluetoothService: NSObject {
//    static let serviceName = "1b7e2df2-d64c-4bcc-99e3-b72c055ff2bb"
//    static var service: CBMutableService {
//        CBMutableService(type: CBUUID(string: serviceName), primary: true)
//    }
//
//    var centralManager: CBCentralManager!
//    var peripheralManager: CBPeripheralManager!
//
//    // Peers
//    var discoveredPeers = [Peer : ConnectionState]()
//    var interestedPeers = Set<Peer>()
//
//    // User
//    var name = ""
//    var isAdvertising: Bool = false
//    var advertisingFailure: ((Error) -> Void)!
//    var contactsListener: ((Peer, [Contact]) -> Void)!
//
//    override init() {
//        super.init()
//        self.centralManager = CBCentralManager(delegate: self, queue: .main)
//        self.peripheralManager = CBPeripheralManager(
//            delegate: self,
//            queue: .main
//        )
//    }
//
//    func shareContacts(with peer: Peer, contacts: [Contact]) {
//        guard let contactsData = try? JSONEncoder().encode(contacts),
//              case let .peripheral(receiver) = peer.connection else { return }
//        receiver
//            .writeValue(
//                contactsData,
//                for: .contacts,
//                type: .withoutResponse
//            )
//    }
//}
