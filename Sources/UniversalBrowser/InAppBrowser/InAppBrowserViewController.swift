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
    

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topExitButton: UIButton!
    @IBOutlet weak var topForwardButton: UIButton!
    @IBOutlet weak var topBackButton: UIButton!
    @IBOutlet weak var topReloadButton: UIButton!
    @IBOutlet weak var bottomForwardButton: UIButton!
    @IBOutlet weak var bottomBackButton: UIButton!
    @IBOutlet weak var bottomReloadButton: UIButton!
    @IBOutlet weak var flottingExitButton: UIButton!
    
    public static let viewController = UIStoryboard(name: "UBStoryBoard", bundle: Bundle.module).instantiateViewController(withIdentifier: "InAppBrowserView") as! InAppBrowserViewController
    
    public override func viewDidLoad() {
        super.viewDidLoad()
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
    @objc func buttonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func topExitButtonTapped(_ sender: UIButton) {
        // Add your code here to handle the topExitButton tap
    }

    @IBAction func topForwardButtonTapped(_ sender: UIButton) {
        // Add your code here to handle the topForwardButton tap
    }

    @IBAction func topBackButtonTapped(_ sender: UIButton) {
        // Add your code here to handle the topBackButton tap
    }

    @IBAction func topReloadButtonTapped(_ sender: UIButton) {
        // Add your code here to handle the topReloadButton tap
    }

    @IBAction func bottomForwardButtonTapped(_ sender: UIButton) {
        // Add your code here to handle the bottomForwardButton tap
    }

    @IBAction func bottomBackButtonTapped(_ sender: UIButton) {
        // Add your code here to handle the bottomBackButton tap
    }

    @IBAction func bottomReloadButtonTapped(_ sender: UIButton) {
        // Add your code here to handle the bottomReloadButton tap
    }

    @IBAction func flottingExitButtonTapped(_ sender: UIButton) {
        // Add your code here to handle the flottingExitButton tap
    }

    
}









//        setupWebView()
//        //hide navigationController
//        navigationController?.navigationBar.isHidden = true
//
//
//        backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left.circle"), style: .plain, target: self, action: #selector(forwardButtonAction))
//
//        forwardButton = UIBarButtonItem(image: UIImage(systemName: "arrow.right.circle"),style: .plain,  target: self,  action: #selector(backButtonAction))
//
//        reloadButton = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise.circle"),style: .plain,  target: self,  action: #selector(reloadButtonAction))
//
//        navigationItem.rightBarButtonItems = [reloadButton,forwardButton , backButton]
    }
    
//    func setupWebView() {
//        webView = WKWebView()
//        webView.frame = view.bounds
//
//        view.addSubview(webView)
//        webView.translatesAutoresizingMaskIntoConstraints = false
//
//        let guide = view.safeAreaLayoutGuide
//        NSLayoutConstraint.activate([
//            webView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
//            webView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
//            webView.topAnchor.constraint(equalTo: guide.topAnchor),
//            webView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
//        ])
//
//        if let url = URL(string: "https://www.apple.com") {
//            let request = URLRequest(url: url)
//            webView.load(request)
//        }
//
//            let button = UIButton(type: .system)
//            button.setTitle("My Button", for: .normal)
//            button.translatesAutoresizingMaskIntoConstraints = false
//            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
//            view.addSubview(button)
//
//            NSLayoutConstraint.activate([
//                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                button.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -20) // Adjust the constant for desired vertical position
//            ])
//    }
    
