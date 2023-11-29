//
//  UserAuthVC.swift
//  UniversalBrowserDemo
//
//  Created by BJIT on 11/10/23.
//

import UIKit
import WebKit

public class UBUserAuthVC: UIViewController{

    @IBOutlet weak var webView: WKWebView!

    public func setInfo(url:String, handlers:[String]){
        UserAuthConstant.loginUrl = url
        UserAuthConstant.messageHandler = handlers
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupWebView()
        self.loadWebView()
    }
}

extension UBUserAuthVC {
    
    private func setupWebView(){
        self.webView.allowsBackForwardNavigationGestures = true
        self.webView.configuration.preferences.javaScriptEnabled = true
        
        // adding javascript callback handler
        let contentController = WKUserContentController()
        webView.configuration.userContentController = contentController
        for handler in UserAuthConstant.messageHandler{
            webView.configuration.userContentController.add(self, name: handler)
        }
    }
    private func loadWebView(){
        if let url = URL(string: UserAuthConstant.loginUrl){
            let request = URLRequest(url: url)
            self.webView.load(request);
        }
    }
}



// MARK: - WKScriptMessageHandler

extension UBUserAuthVC: WKScriptMessageHandler {
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

        if let bodyStr = message.body as? String, let data = bodyStr.data(using: .utf8){
            do {
                let auth = try JSONDecoder().decode(AuthModel.self, from: data)
//                print("status: ", auth.status)

                switch auth.status {
                case "OK":
                    if let token = auth.token{
                        UserDefaults.standard.set(token, forKey: UserAuthConstant.authTokenKey)
                    }
                    let actionSheet = UIAlertController(title: nil, message: "Login Successful", preferredStyle: .alert)
                    let myAction = UIAlertAction(title: "OK", style: .default){ (action) in
                        self.dismiss(animated: true)
                    }
                    actionSheet.addAction(myAction)
                    present(actionSheet,animated: true)
                default:
                    let actionSheet = UIAlertController(title: nil, message: "Login Failed", preferredStyle: .alert)
                    let myAction = UIAlertAction(title: "OK", style: .destructive){ (action) in
                        self.dismiss(animated: true)
                    }
                    actionSheet.addAction(myAction)
                    present(actionSheet,animated: true)
                }
            }
            catch let error{
                print("json decoding error: ", error.localizedDescription)
            }
        }
    }
}
