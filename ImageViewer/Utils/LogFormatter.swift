//
//  LogFormatter.swift
//  ImageViewer
//
//  Created by Admin on 5/31/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import CocoaLumberjack

public class LogFormatter: NSObject, DDLogFormatter {
    let dateFormatter = DateFormatter()
    let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] ?? "unknown_app"
    
    public override init() {
        super.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSSZ"
    }
    
    public func format(message logMessage: DDLogMessage) -> String? {
        let logLevel: String
        switch logMessage.flag {
        case DDLogFlag.error:
            logLevel = "ERROR"
        case DDLogFlag.warning:
            logLevel = "WARNING"
        case DDLogFlag.info:
            logLevel = "INFO"
        case DDLogFlag.debug:
            logLevel = "DEBUG"
        default:
            logLevel = "VERBOSE"
        }
        
        let dt = dateFormatter.string(from: logMessage.timestamp)
        let logMsg = logMessage.message
        let lineNumber = logMessage.line
        let file = logMessage.file
        let functionName = logMessage.function
        let threadId = logMessage.threadID
        
        return "\(dt) \(appName)[\(threadId)] [\(logLevel)] \(logMsg) (\(file):\(lineNumber) - \(functionName ?? "anonymous"))"
    }
}
