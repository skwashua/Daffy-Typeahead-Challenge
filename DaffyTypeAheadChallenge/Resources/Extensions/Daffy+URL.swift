//
//  Daffy+URL.swift
//  DaffyTypeAheadChallenge
//
//  Created by Joshua Lytle on 5/14/24.
//

import Foundation

extension URL {
    static func add(_ queryParams: [String: String]?, toQuery query: String, encodePlus: Bool = false) -> String {
        guard let params = queryParams else { return query }
        
        var queryWithParams = query

        if queryWithParams.range(of: "?") == nil  {
            queryWithParams += "?"
        } else {
            queryWithParams += "&"
        }
        
        var allowedCharacters = CharacterSet.urlQueryAllowed
        
        if encodePlus {
            allowedCharacters.remove("+")
        }
        
        for key in Array(params.keys).sorted(by: <) {
            if let escapedValue = params[key]?.addingPercentEncoding(withAllowedCharacters: allowedCharacters) {
                queryWithParams += "\(key)=\(escapedValue)&"
            }
        }
        
        // Remove trailing ampersand.
        if queryWithParams.last == "&" {
            queryWithParams = String(queryWithParams[..<queryWithParams.index(before: queryWithParams.endIndex)])
        }
        
        return queryWithParams
    }
}
