//
//  AlertData.swift
//  flutter_native_dialog
//
//  Created by Wouter Hardeman on 19/01/2019.
//

import Foundation

struct AlertData {
    static let DEFAULT_POSITIVE_BUTTON_TEST: String = "OK"
    static let DEFAULT_NEGATIVE_BUTTON_TEST: String = "Cancel"
    
    let title: String?
    let message: String?
    let positiveButtonMessage: String
    let negativeButtonMessage: String
    let destructive: Bool
    init(withDictionary dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String
        self.message = dictionary["message"] as? String
        self.positiveButtonMessage = dictionary["positiveButtonMessage"] as? String ?? AlertData.DEFAULT_POSITIVE_BUTTON_TEST
        self.negativeButtonMessage = dictionary["negativeButtonMessage"] as? String ?? AlertData.DEFAULT_NEGATIVE_BUTTON_TEST
        self.destructive = dictionary["destructive"] as? Bool ?? false
    }
    
}
