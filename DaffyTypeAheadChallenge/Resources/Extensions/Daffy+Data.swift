//
//  Daffy+Data.swift
//  DaffyTypeAheadChallenge
//
//  Created by Joshua Lytle on 5/14/24.
//

import Foundation

extension Data {
    func jsonString() -> String? {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .withoutEscapingSlashes) {
            return String(decoding: jsonData, as: UTF8.self)
        } else {
            return nil
        }
    }
}
