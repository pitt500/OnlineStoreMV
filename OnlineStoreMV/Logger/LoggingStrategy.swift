//
//  LoggingStrategy.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 16/09/24.
//


protocol LoggingStrategy {
    func log(_ message: String)
    func clear()
    func getLoggedMessages() -> [String]
}
