////
////  CharacteristicTypes.swift
////  Mutually
////
////  Created by Abdulaziz Albahar on 1/26/25.
////
//
//import CoreBluetooth
//
//extension CBCharacteristic {
//    static var name: CBMutableCharacteristic {
//        CBMutableCharacteristic(
//            type: .name,
//            properties: .write,
//            value: nil,
//            permissions: .readable
//        )
//    }
//
//    static var contacts: CBMutableCharacteristic {
//        CBMutableCharacteristic(
//            type: .contacts,
//            properties: .write,
//            value: nil,
//            permissions: .readable
//        )
//    }
//}
//
//extension CBUUID {
//    static var name: CBUUID {
//        CBUUID(string: "60a7ecd7-f9ab-4730-b2cb-a94c4a01d6d3")
//    }
//
//    static var contacts: CBUUID {
//        CBUUID(string: "76a04492-ba4e-43d3-98b7-218f8c7b2883")
//    }
//}
//
//enum MessageType: String {
//    case name, contacts
//}
