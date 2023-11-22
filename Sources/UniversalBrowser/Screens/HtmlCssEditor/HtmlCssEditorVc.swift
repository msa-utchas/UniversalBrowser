//
//  HtmlCssEditorVc.swift
//  
//
//  Created by MD SAKIBUL ALAM UTCHAS_0088 on 16/11/23.
//

import UIKit
import WebKit

public class HtmlCssEditorVc: UIViewController{
    
    public static let viewController = UIStoryboard(name: "UBStoryBoard", bundle: Bundle.module).instantiateViewController(withIdentifier: "HtmlCssEditor") as! HtmlCssEditorVc

    @IBOutlet weak var textArea: UITextView!
    @IBOutlet weak var webView: WKWebView!
    var capturedText: String = ""
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        textArea.text = capturedText
        webView.uiDelegate = self
        webView.navigationDelegate = self
        textArea.delegate = self
        textArea.text = capturedText
    }
    
    @IBAction func renderCode(_ sender: Any) {
        webView.loadHTMLString(capturedText, baseURL: nil)
    }
    

}

extension HtmlCssEditorVc: UITextViewDelegate{
    public func textViewDidChange(_ textView: UITextView) {
        capturedText = textView.text!
        webView.loadHTMLString(capturedText, baseURL: nil)
        
    }
}
extension HtmlCssEditorVc: WKUIDelegate{
    
}

extension HtmlCssEditorVc: WKNavigationDelegate{
    
}


