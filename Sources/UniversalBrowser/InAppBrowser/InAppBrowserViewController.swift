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
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            webView.topAnchor.constraint(equalTo: guide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
        
        if let url = URL(string: "https://www.apple.com") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        // Create a UIButton
            let button = UIButton(type: .system)
            button.setTitle("My Button", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(button)

            // Add constraints to center the button at the bottom
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -20) // Adjust the constant for desired vertical position
            ])
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









