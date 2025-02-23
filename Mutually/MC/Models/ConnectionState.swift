//
//  ConnectionState.swift
//  Mutually
//
//  Created by Abdulaziz Albahar on 1/28/25.
//


enum ConnectionState {
    case discovered, failed(Error?), connecting, connected

    var display: String {
        switch self {
        case .discovered:
            "Discovered"
        case .failed(_):
            "Failed"
        case .connected:
            "Connected"
        case .connecting:
            "Connecting"
        }
    }
}
