//
//  GifDetailView.swift
//  DaffyTypeAheadChallenge
//
//  Created by Joshua Lytle on 5/14/24.
//

import SwiftUI
import GiphyUISDK

struct GifDetailView: View {
    var media: GPHMedia
    private var link: LocalizedStringKey {
        return LocalizedStringKey("[View on Giphy](\(media.url))")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            GifMediaView(media: media)
                .aspectRatio(contentMode: .fit)
                .clipShape(.rect(cornerRadius: 12.0))
            
            if let title = media.title {
                Text(title)
                    .bold()
            }
            
            Spacer()
            
            Link(destination: URL(string: media.url)!) {
                HStack {
                    Spacer()
                    
                    Text("View on Giphy")
                        .frame(height: 40.0)
                        .foregroundStyle(Color.black)
                    
                    Spacer()
                }
                .background(Color.white)
                .clipShape(.capsule)
            }
        }
        .padding()
        .background(Color.mint)
    }
}

#Preview {
    GifDetailView(media: GPHMedia())
}
