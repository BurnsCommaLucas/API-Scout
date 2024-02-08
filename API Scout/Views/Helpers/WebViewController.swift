//
//  WebViewController.swift
//  API Scout
//
//  Created by Lucas on 2/6/24.
//

import Foundation
import AppKit
import WebKit
import SwiftUI

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    var renderableContent: String
    var baseUrl: String?
    
    func makeNSView(context: Context) -> WKWebView  {
        let wkwebView = WKWebView()
        let urlObject: URL? = baseUrl != nil ? URL(string: baseUrl!) : nil
        wkwebView.loadHTMLString(renderableContent, baseURL: urlObject)
        return wkwebView
    }
    
    func updateNSView(_ uiView: WKWebView, context: Context) {
    }
}

#Preview {
    WebView(renderableContent: sampleHtml, baseUrl: "https://img.shields.io")
}
