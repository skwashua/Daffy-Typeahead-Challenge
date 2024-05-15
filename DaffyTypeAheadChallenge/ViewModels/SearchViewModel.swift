//
//  SearchViewModel.swift
//  DaffyTypeAheadChallenge
//
//  Created by Joshua Lytle on 5/14/24.
//

import Foundation
import Combine
import GiphyUISDK

class SearchViewModel: ObservableObject {
    @Published var searchResults: [GPHMedia] = []
    @Published var trendingResults: [GPHMedia] = []
    @Published var searchText: String = ""
    @Published var searching: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    private var searchTextCancellable: AnyCancellable?
    
    func load() {
        SearchService().fetchTrending()
            .receive(on: RunLoop.main)
            .sink { completion in
                debugPrint("Fetch Trending: \(completion)")
            } receiveValue: { [unowned self] results in
                self.trendingResults = results.data
            }
            .store(in: &cancellables)
        
        searchTextCancellable = $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [unowned self] text in
                self.search(text)
            }
    }
    
    func search(_ text: String) {
        //Clears any pending requests.
        cancellables.removeAll()
        
        guard !text.isEmpty else {
            searchResults = []
            return
        }
        
        SearchService().search(text: text, offset: 0)
            .receive(on: RunLoop.main)
            .sink { [unowned self] completion in
                debugPrint("Search Complete: \(completion)")
                self.searching = false
            } receiveValue: { [unowned self] result in
                self.searchResults = result.data
            }
            .store(in: &cancellables)
    }
    
    func loadNextPageIfNeeded(mediaId: String) {
        guard !searching else { return }
        
        let lastFive = searchResults.suffix(5)
        guard lastFive.contains(where: { $0.id == mediaId }) else { return }
        
        searching = true
        
        SearchService().search(text: searchText, offset: searchResults.count)
            .receive(on: RunLoop.main)
            .sink { [unowned self] completion in
                debugPrint("Search Complete: \(completion)")
                self.searching = false
            } receiveValue: { [unowned self] result in
                self.searchResults.append(contentsOf: result.data)
            }
            .store(in: &cancellables)
    }
}
