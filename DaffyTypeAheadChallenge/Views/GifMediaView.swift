//
//  GifMediaView.swift
//  DaffyTypeAheadChallenge
//
//  Created by Joshua Lytle on 5/14/24.
//

import SwiftUI
import UIKit
import GiphyUISDK

struct GifMediaView: UIViewRepresentable {
    var media: GPHMedia?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
    
    func makeUIView(context: Context) -> some UIView {
        let mediaView = GPHMediaView()
        mediaView.media = self.media
        return mediaView
    }
    
    class Coordinator: NSObject {
        var control: GifMediaView


        init(_ control: GifMediaView) {
            self.control = control
        }
    }
}
