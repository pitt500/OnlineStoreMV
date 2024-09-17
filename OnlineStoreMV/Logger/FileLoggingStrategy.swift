//
//  FileLoggingStrategy.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 16/09/24.
//

import Foundation

class FileLoggingStrategy: LoggingStrategy {
    private let fileURL: URL
    
    init(fileURL: URL) {
        self.fileURL = fileURL
    }
    
    func log(_ message: String) {
        do {
            let data = (message + "\n").data(using: .utf8)!
            if FileManager.default.fileExists(atPath: fileURL.path) {
                let fileHandle = try FileHandle(forWritingTo: fileURL)
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            } else {
                try data.write(to: fileURL)
            }
            print("[FileLoggingStrategy] Logged message to file: \(message)")
        } catch {
            print("Failed to log message to file: \(error.localizedDescription)")
        }
    }
    
    func getLoggedMessages() -> [String] {
        do {
            let data = try Data(contentsOf: fileURL)
            let content = String(data: data, encoding: .utf8)
            return content?.components(separatedBy: "\n").filter { !$0.isEmpty } ?? []
        } catch {
            print("Failed to read log messages from file: \(error.localizedDescription)")
            return []
        }
    }
    
    func clear() {
        do {
            try "".write(to: fileURL, atomically: true, encoding: .utf8)
            print("[FileLoggingStrategy] Cleared all log messages from file.")
        } catch {
            print("Failed to clear log messages: \(error.localizedDescription)")
        }
    }
}
