//
//  Log.swift
//  Coinmarketcap Test
//
//  Created by Roman Slysh on 9/6/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

func dLog(_ objects: Any..., file: String = #file, line: Int = #line, indent: String = "  ", printArray: Bool = true) {
    #if DEBUG
    aLog(objects, file: file, line: line, indent: indent, printArray: printArray)
    #endif
}

func aLog(_ objects: Any..., file: String = #file, line: Int = #line, indent: String = "  ", printArray: Bool = true) {
    guard let fileName = file.components(separatedBy: "/").last else {
        return
    }

    for object in objects {
        if let array = object as? [Any], printArray == true {
            print("\(fileName)(\(line)):")
            logArray(array, "  \(indent)")
        } else {
            print("\(fileName)(\(line)): \(object)")
        }
    }
}

private func logArray(_ array: [Any], _ indent: String) {
    for object in array {
        if let nArray = object as? [Any] {
            logArray(nArray, "  \(indent)")
        } else {
            print("\(indent)\(object)")
        }
    }
}
