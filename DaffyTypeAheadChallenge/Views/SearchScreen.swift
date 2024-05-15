//
//  SearchScreen.swift
//  DaffyTypeAheadChallenge
//
//  Created by Joshua Lytle on 5/14/24.
//

import SwiftUI
import Combine
import GiphyUISDK

struct SearchScreen: View {
    @StateObject var viewModel = SearchViewModel()
    @State var selectedMediaItem: GPHMedia?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12.0) {
                TextField(text: $viewModel.searchText, prompt: Text("'swift', 'interview', 'daffy', etc")) {
                    Text("Gif Search")
                        .frame(height: 40.0)
                }
                .padding()
                .background(Color.white)
                .clipShape(.capsule)
                .padding(.horizontal)
                
                ScrollView {
                    if viewModel.searchText.isEmpty {
                        trendingResultsView
                    } else {
                        Text("showing results for \"\(viewModel.searchText)\"")
                            .foregroundStyle(.white)
                            .italic()
                        
                        searchResultsView
                    }
                    
                    if viewModel.searching {
                        ProgressView()
                    }
                    
                    Spacer(minLength: 45.0)
                }
            }
            .background(Color.mint)
            .task {
                viewModel.load()
            }
            .navigationDestination(item: $selectedMediaItem) { item in
                GifDetailView(media: item)
            }
        }

    }
    
    @ViewBuilder
    var trendingResultsView: some View {
        LazyVStack(spacing: 12.0) {
            ForEach(viewModel.trendingResults) { result in
                GifMediaView(media: result)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(.rect(cornerRadius: 12.0))
                    .padding(.horizontal, 12.0)
                    .onTapGesture {
                        self.selectedMediaItem = result
                    }
            }
        }
    }
    
    @ViewBuilder
    var searchResultsView: some View {
        LazyVStack(spacing: 12.0) {
            ForEach(viewModel.searchResults) { result in
                GifMediaView(media: result)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(.rect(cornerRadius: 12.0))
                    .padding(.horizontal, 12.0)
                    .onAppear {
                        viewModel.loadNextPageIfNeeded(mediaId: result.id)
                    }
                    .onTapGesture {
                        self.selectedMediaItem = result
                    }
            }
        }
    }
}

#Preview {
    SearchScreen()
}
