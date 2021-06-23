//
//  Dictionary+QueryString.swift
//  MyFlickr
//
//  Created by Nirmal Choudhari on 21/06/21.
//

import Foundation

/// Converts a Given Dictionary to querystring
extension Dictionary where Key == String {

    // Shortcut -  Does not suport nesting for values, function may crash for other types than String. Not implemetned as both apis as of now donot need it
    func queryString() -> String {
        var components: [(String, String)] = []
        for key in keys {
            let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? key
            let value = self[key]
            if let number = value as? NSNumber {
                let val = number.boolValue ? "1" : "0"
                components.append((escapedKey, val))
            } else if let bool = value as? Bool {
                let val = bool ? "true" : "false"
                components.append((escapedKey, val))
            } else  if let value = value as? String {
                let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? value
                components.append((escapedKey, escapedValue))
            }

        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
}
