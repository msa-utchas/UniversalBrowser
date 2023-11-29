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
}

@available(iOS 13.0, *)
public class UBPaymentVC: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    var viewModel: PaymentViewModel = PaymentViewModel()
    var cancellable = Set<AnyCancellable>()
    
    private var _paymentURL: String!
    private var _paymentSuccessURL: String!
    private var _paymentFailedURL: String!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: _paymentURL){
            let request = URLRequest(url: url)
            webView.navigationDelegate = self
            webView.load(request)
            
            
        }
        addViewModelBindings()
        
    }
    public func setPaymentUrl(paymentUrl: String, paymentSuccessURL: String, paymentFailedURL:String){
        _paymentURL = paymentUrl
        _paymentSuccessURL = paymentSuccessURL
        _paymentFailedURL = paymentFailedURL
        
    }
    
    func addViewModelBindings() {
        viewModel.$paymentResponseStatus.sink(receiveValue: { [weak self] paymentResponseStatus in
            guard let self = self else { return }
            switch paymentResponseStatus {
            case .success:
                self.showPaymentAlert(message: "Payment was successful.")
            case .failed:
                self.showPaymentAlert(message: "Payment failed.")
            case .none:
                print("Payment began")
            }
            
        }).store(in: &cancellable)
    }
    
    func showPaymentAlert(message: String) {
            let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)

            let okAction = UIAlertAction(title: "Done", style: .default, handler: { _ in
                if let nav = self.navigationController{
                    nav.popViewController(animated: true)
                }
                else{
                    self.dismiss(animated: true)
                }
            })
            alertController.addAction(okAction)

            present(alertController, animated: true, completion: nil)
        }
}


@available(iOS 13.0, *)
extension UBPaymentVC: WKNavigationDelegate{
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
