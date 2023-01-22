//
//  ViewController.swift
//  Project4
//
//  Created by Ильфат Салахов on 21.01.2023.
//

import WebKit
import UIKit

final class MainViewController: UIViewController, WKNavigationDelegate {
    
    //MARK: -Public Property
    var website: String!
    
    // MARK: -Private property
    private var webView: WKWebView!
    private var progressView: UIProgressView!
    
    // MARK: -Override methods
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProgressView()
        setupToolBar()
        setupNavigationController()
        setupWebView()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    // MARK: -Public Methods
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            if host.contains(website) {
                decisionHandler(.allow)
                return
            }
        }
        decisionHandler(.cancel)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    // MARK: -Private Methods
    private func openPage(action: UIAlertAction!) {
        guard let url = URL(string: "https://" + (action.title ?? "")) else { return }
        webView.load(URLRequest(url: url))
    }
    
    private func setupView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    private func setupProgressView() {
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
    }
    
    private func setupToolBar() {
        let progressButton = UIBarButtonItem(customView: progressView)
        let goBackButton = UIBarButtonItem(barButtonSystemItem: .rewind, target: webView, action: #selector(webView.goBack))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let goForwardButton = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webView, action: #selector(webView.goForward))
        
        toolbarItems = [goBackButton, spacer, progressButton, spacer, goForwardButton]
    }
    
    private func setupNavigationController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                            target: webView,
                                                            action: #selector(webView.reload))
        
        navigationController?.isToolbarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupWebView() {
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        guard let url = URL(string: "https://" + (website)) else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}


