//
//  HomeService.swift
//  JoshLytleResume
//
//  Created by Joshua Lytle on 5/20/23.
//

import Foundation
import Combine

/// NOTE: This code is an example of a simple service accessing a REST API.
/// Code modified from my personal project at https://github.com/skwashua/JoshLytleResume
struct SearchService: WebService {
    enum Endpoint: String {
        case search = "/v1/gifs/search"
        case trending = "/v1/gifs/trending"
    }
    
    func search(text: String, offset: Int) -> AnyPublisher<SearchResult, Error> {
        var params: [String: String] = [:]
        params["api_key"] = Constants.giphyAPIKey
        params["rating"] = "pg-13"
        params["q"] = text
        params["offset"] = String(offset)
        
        let endpoint = Environment.shared.url(route: Endpoint.search.rawValue, queryParams: params)
        
        return BaseService().get(endpoint: endpoint)
            .decode(type: SearchResult.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func fetchTrending() -> AnyPublisher<SearchResult, Error> {
        var params: [String: String] = [:]
        params["api_key"] = Constants.giphyAPIKey
        params["rating"] = "pg-13"

        let endpoint = Environment.shared.url(route: Endpoint.trending.rawValue, queryParams: params)
        
        return BaseService().get(endpoint: endpoint)
            .decode(type: SearchResult.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
