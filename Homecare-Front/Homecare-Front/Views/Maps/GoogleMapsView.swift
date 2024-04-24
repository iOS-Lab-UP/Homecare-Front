//
//  GoogleMapsView.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 24/04/24.
//
import SwiftUI
import WebKit



struct WebView: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}


struct MapView: View {
    var body: some View {
        NavigationView {
            WebView(url: URL(string: "https://www.google.com/maps/search/oxxo+near+me/@25.6413922,-100.293669,15z/data=!3m1!4b1?entry=ttu")!)
                .navigationBarTitle("Oxxos cerca de mi")
        }
    }
}
