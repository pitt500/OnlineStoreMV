//
//  Logger.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 16/09/24.
//

import Foundation

class Logger {
    private var strategy: LoggingStrategy
    
    init(strategy: LoggingStrategy) {
        self.strategy = strategy
    }

    func setStrategy(_ strategy: LoggingStrategy) {
        self.strategy = strategy
    }
    
    func log(_ message: String) {
        strategy.log(message)
    }
    
    func getLoggedMessages() -> [String] {
        strategy.getLoggedMessages()
    }
    
    func clear() {
        strategy.clear()
    }
}

extension Logger {

    static var inMemory: Logger {
        return Logger(strategy: InMemoryStrategy())
    }
    
    static func fileLogging(fileURL: URL) -> Logger {
        return Logger(strategy: FileLoggingStrategy(fileURL: fileURL))
    }
}
