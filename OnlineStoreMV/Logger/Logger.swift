//
//  Logger.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 16/09/24.
//


protocol Logger {
    func log(_ message: String)
    func clear()
    func getLoggedMessages() -> [String]
}
