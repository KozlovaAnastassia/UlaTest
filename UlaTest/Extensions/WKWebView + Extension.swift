//
//  WebView + Extension.swift
//  UlaTest
//
//  Created by Анастасия on 31.03.2024.
//

import WebKit

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
