//
//  InMemoryStrategy.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 16/09/24.
//

class InMemoryStrategy: LoggingStrategy {
    private var logs: [String] = []
    
    func log(_ message: String) {
        logs.append(message)
    }
    
    func clear() {
        logs.removeAll()
    }
    
    func getLoggedMessages() -> [String] {
        logs
    }
}
