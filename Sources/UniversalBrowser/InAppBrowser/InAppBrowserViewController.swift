//
//  InAppBrowserViewController.swift
//
//
//  Created by MD SAKIBUL ALAM UTCHAS_0088 on 1/11/23.
//

import UIKit
import WebKit

public class InAppBrowserViewController: UIViewController {
    
    public static let viewController = UIStoryboard(name: "UBStoryBoard", bundle: Bundle.module).instantiateViewController(withIdentifier: "InAppBrowserView") as! InAppBrowserViewController
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    func setupWebView() {
        
        let webView = WKWebView()
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
    
}





    
    
    

