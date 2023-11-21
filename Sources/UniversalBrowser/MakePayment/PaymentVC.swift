//
//  PaymentVC.swift
//
//
//  Created by MD SAKIBUL ALAM UTCHAS_0088 on 21/11/23.
//

import UIKit
import WebKit
import Combine

enum ResponseStatus:String{
    case success = "success"
    case failed = "failed"
    case pending = "pending"
}

@available(iOS 13.0, *)
public class PaymentVC: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    var viewModel: PaymentViewModel = PaymentViewModel()
    var cancellable = Set<AnyCancellable>()
    
    private var _paymentURL: String!
    private var _paymentSuccessURL: String!
    private var _paymentFailedURL: String!
    
    public static let viewController = UIStoryboard(name: "UBStoryBoard", bundle: Bundle.module).instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
    public override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: _paymentURL){
            let request = URLRequest(url: url)
            webView.navigationDelegate = self
            webView.load(request)
            
        }
        
    }
    public func setPaymentUrl(paymentUrl: String, paymentSuccessURL: String, paymentFailedURL:String){
        _paymentURL = paymentUrl
        _paymentSuccessURL = paymentUrl
        _paymentFailedURL = paymentFailedURL
        
    }
}

@available(iOS 13.0, *)
extension PaymentVC: WKNavigationDelegate{
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let urlAsString = navigationAction.request.url?.absoluteString.lowercased() else {
            return
        }
        if urlAsString.range(of: _paymentSuccessURL) != nil {
            viewModel.paymentResponseStatus = .success
        }
        if urlAsString.range(of: _paymentFailedURL) != nil {
            viewModel.paymentResponseStatus = .failed
        }
        decisionHandler(.allow)
    }
}
