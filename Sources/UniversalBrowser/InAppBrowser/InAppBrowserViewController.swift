//
//  InAppBrowserViewController.swift
//
//
//  Created by MD SAKIBUL ALAM UTCHAS_0088 on 1/11/23.
//

import UIKit
import WebKit

@available(iOS 13.0, *)
public class InAppBrowserViewController: UIViewController {
    
    var webView:WKWebView!
    var backButton: UIBarButtonItem!
    var forwardButton: UIBarButtonItem!
    var reloadButton: UIBarButtonItem!
    
    
    public static let viewController = UIStoryboard(name: "UBStoryBoard", bundle: Bundle.module).instantiateViewController(withIdentifier: "InAppBrowserView") as! InAppBrowserViewController
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        
        
        backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left.circle"), style: .plain, target: self, action: #selector(forwardButtonAction))
        
        forwardButton = UIBarButtonItem(image: UIImage(systemName: "arrow.right.circle"),style: .plain,  target: self,  action: #selector(backButtonAction))
    
        reloadButton = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise.circle"),style: .plain,  target: self,  action: #selector(reloadButtonAction))
        
        navigationItem.rightBarButtonItems = [reloadButton,forwardButton , backButton]
    }
    
    func setupWebView() {
        webView = WKWebView()
        webView.frame = view.bounds
        
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        if let url = URL(string: "https://www.apple.com") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    
    @objc func forwardButtonAction() {
        if webView.canGoBack{
            webView.goBack()
        }
    }
    
    @objc func backButtonAction() {
        if webView.canGoForward{
            webView.goForward()
        }
    }
    
    @objc func reloadButtonAction() {
        webView.reload()
    }
    
    
}









