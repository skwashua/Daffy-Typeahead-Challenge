//
//  Environment.swift
//  JoshLytleResume
//
//  Created by Joshua Lytle on 5/20/23.
//

import Foundation


/// NOTE: This code is a base example of how I would start to build an Environment class to support dev/prod environments.
/// Code modified from my personal project at https://github.com/skwashua/JoshLytleResume
class Environment {
    static let shared = Environment()
    var defaultWebProtocol = "https://"
    var defaultDomain = "api.giphy.com"
    
    internal required init() { }
    
    func url(route: String, replacements: [String: String] = [:], queryParams: [String: String]? = nil, encodePlus: Bool = false) -> URL? {
        var fullUrl = defaultWebProtocol + defaultDomain + route
        
        for (key, value) in replacements {
            fullUrl = fullUrl.replacingOccurrences(of: "{\(key)}", with: value)
        }
        
        if let queryParams = queryParams, !queryParams.isEmpty {
            fullUrl = URL.add(queryParams, toQuery: fullUrl, encodePlus: encodePlus)
        }
        
        return URL(string: fullUrl)
    }
}
