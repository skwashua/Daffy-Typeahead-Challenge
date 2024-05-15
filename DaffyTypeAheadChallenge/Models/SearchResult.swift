//
//  SearchResult.swift
//  DaffyTypeAheadChallenge
//
//  Created by Joshua Lytle on 5/14/24.
//

import Foundation
import GiphyUISDK

struct SearchResult: Codable {
    var data: [GPHMedia]
}

extension GPHMedia: Identifiable {}
