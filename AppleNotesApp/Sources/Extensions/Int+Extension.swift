//
//  Int+Extension.swift
//  AppleNotesApp
//
//  Created by Анна Лошакова on 10.10.2022.
//

import Foundation

extension Int {
    
    func showCountNote() -> String {
        switch self % 10 {
        case 0:
            return "\(self) заметок"
        case 1:
            return "\(self) заметка"
        case 2...4:
            return "\(self) заметки"
        case 5...9:
            return "\(self) заметок"
        default:
            return String(self)
        }
    }
}
