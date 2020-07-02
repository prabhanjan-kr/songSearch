//
//  WebContentDisplayViewController.swift
//  Song Search
//
//  Created by prabhanjan on 07/06/20.
//  Copyright © 2020 manorishi. All rights reserved.
//

import Foundation
import WebKit
import SVProgressHUD

class WebContentDisplayViewController: ViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var redirectionURL :String?
    
    override func viewDidLoad() {
        //
        self.webView.navigationDelegate = self
        self.webView.uiDelegate = self
        self.loadWebPage()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        SVProgressHUD.dismiss()
    }
    
    func loadWebPage() {
        SVProgressHUD.show()
        let url = URL(string: self.redirectionURL ?? K.fallBackRedirectionURL)
        let urlRequest = URLRequest(url: url!)
        self.webView.load(urlRequest)
    }
}

extension WebContentDisplayViewController :WKNavigationDelegate, WKUIDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    
}
