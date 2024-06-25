//
//  SplashViewController.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

extension String {
    
    func localizedString() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func ConvertStringTodayName() -> String? {
        if let date = ISO8601DateFormatter().date(from: self) {
            let formatter = DateFormatter()
            formatter.dateFormat = "E"
            return formatter.string(from: date)
        }
        return nil
    }
    
    func convertStringToTime() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "h:mm a"
            let timeString = dateFormatter.string(from: date)
            return timeString
        } else {
            print("Invalid date format")
            return nil
        }
    }
}
//MARK: Decodable
extension Decodable {
    
    static func decode(data: Data?) -> Self? {
        guard let data = data else { return nil }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Self.self, from: data)
        } catch(let error) {
            print(error)
            return nil
        }
    }
}

//MARK: Encodable
extension Encodable {
    func encode() -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do { return try encoder.encode(self) } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    var postDictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
    var paramString: String {
        let strFromDict = (postDictionary.compactMap ({ (key ,value) -> String in
            return "\(key)=\(value)"
        }) as Array).joined(separator: "&")
        return "?" + strFromDict
    }
    
    
}



