//
//  InAppBrowserViewController.swift
//
//
//  Created by MD SAKIBUL ALAM UTCHAS_0088 on 1/11/23.
//

import UIKit
import WebKit
public enum NavigationType {
    case top
    case bottom
}

public enum ButtonConfiguration {
    case allButtons
    case backAndForward
    case reload
}

@available(iOS 13.0, *)
public class InAppBrowserViewController: UIViewController, WKNavigationDelegate, WKUIDelegate{
    
    @IBOutlet weak var topExitButtonImage: UIImageView!
    @IBOutlet weak var topBackButtonImage: UIImageView!
    @IBOutlet weak var topForwardButtonImage: UIImageView!
    @IBOutlet weak var topReloadButtonImage: UIImageView!
    

    @IBOutlet weak var bottomBackButtonImage: UIImageView!
    @IBOutlet weak var bottomForwardButtonImage: UIImageView!
    @IBOutlet weak var bottomReloadButtonImage: UIImageView!
    

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var topForwardButton: UIButton!
    @IBOutlet weak var topBackButton: UIButton!
    @IBOutlet weak var topReloadButton: UIButton!
    
    @IBOutlet weak var bottomForwardButton: UIButton!
    @IBOutlet weak var bottomBackButton: UIButton!
    @IBOutlet weak var bottomReloadButton: UIButton!
    
    @IBOutlet weak var topExitButton: UIButton!
    @IBOutlet weak var floatingExitButton: UIButton!
    
    public static let viewController = UIStoryboard(name: "UBStoryBoard", bundle: Bundle.module).instantiateViewController(withIdentifier: "InAppBrowserView") as! InAppBrowserViewController
    
    private var _uiBackgroundColor: UIColor = .white
    private var _navigationType: NavigationType = .top
    private var _isFloatingButtonEnabled: Bool = false
    
    private var _forwardButtonImage: UIImage? = UIImage(systemName: "arrow.right.circle")
    private var _backButtonImage: UIImage? = UIImage(systemName: "arrow.left.circle")
    private var _reloadButtonImage: UIImage? = UIImage(systemName: "arrow.clockwise.circle")
    private var _buttonConfiguration: ButtonConfiguration = .allButtons
    private var _url: String = "apple.com"
    private var _floatingExitButtonBackgroundColor: UIColor = .green
    private var _floatingExitButtonImage: UIImage? = UIImage(systemName: "xmark.circle")




    public override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        topBackButton.isEnabled = false
        bottomBackButton.isEnabled = false
        
        topForwardButton.isEnabled = false
        bottomForwardButton.isEnabled = false
        
        backgroundView.backgroundColor = .red
        
        
        navigationController?.navigationBar.isHidden = true
        setupUI()
        
    }
    
    func forwardButtonAction() {
        if webView.canGoForward{
            webView.goForward()
        }
    }
    
    func backButtonAction() {
        if webView.canGoBack{
            webView.goBack()
        }
    }
    
    func reloadButtonAction() {
        webView.reload()
    }
    func exitButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func topExitButtonTapped(_ sender: UIButton) {
        exitButtonAction()
    }

    @IBAction func topForwardButtonTapped(_ sender: UIButton) {
        forwardButtonAction()
    }

    @IBAction func topBackButtonTapped(_ sender: UIButton) {
        backButtonAction()
    }

    @IBAction func topReloadButtonTapped(_ sender: UIButton) {
        reloadButtonAction()
    }

    @IBAction func bottomForwardButtonTapped(_ sender: UIButton) {
        forwardButtonAction()
    }

    @IBAction func bottomBackButtonTapped(_ sender: UIButton) {
       backButtonAction()
    }

    @IBAction func bottomReloadButtonTapped(_ sender: UIButton) {
        reloadButtonAction()
        
    }

    @IBAction func flottingExitButtonTapped(_ sender: UIButton) {
        exitButtonAction()
    }

    @IBAction func openInBrowser(_ sender: Any) {
        if let url = URL(string: _url) {
            UIApplication.shared.open(url, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly : false]) { (success) in
                if !success {
                    print("URL failed to open")
                }
            }
        }
    }
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let url = webView.url{
            _url = url.absoluteString
        }
        
        if(_buttonConfiguration == .allButtons || _buttonConfiguration == .backAndForward){
            
            if webView.canGoBack{
                topBackButton.isEnabled = true
                bottomBackButton.isEnabled = true
                
                topBackButtonImage.isHidden = false
                bottomBackButtonImage.isHidden = false
            }
            else{
                topBackButton.isEnabled = false
                bottomBackButton.isEnabled = false
                
                topBackButtonImage.isHidden = true
                bottomBackButtonImage.isHidden = true
            }
            if webView.canGoForward{
                topForwardButton.isEnabled = true
                bottomForwardButton.isEnabled = true
                
                topForwardButtonImage.isHidden = false
                bottomForwardButtonImage.isHidden = false
            }
            else{
                topForwardButton.isEnabled = false
                bottomForwardButton.isEnabled = false
                
                topForwardButtonImage.isHidden = true
                bottomForwardButtonImage.isHidden = true
            }
        }
    }


    
    public func setUIBackgroundColor(colour: UIColor) {
        _uiBackgroundColor = colour
    }
    public func setNavigationType(type: NavigationType) {
        _navigationType = type
    }
    public func setFloatingExitButtonEnabled(isEnabled: Bool) {
        _isFloatingButtonEnabled = isEnabled
    }
    public func setForwardButtonImage(image: UIImage?) {
        _forwardButtonImage = image
    }
    public func setBackButtonImage(image: UIImage?) {

        _backButtonImage = resizeImage(image: image)
    }
    public func setReloadButtonImage(image: UIImage?) {
        _reloadButtonImage = image
    }
    public func setButtonConfiguration(configuration: ButtonConfiguration) {
        _buttonConfiguration = configuration
    }
    public func setUrl(url: String) {
        _url = url
    }
    public func setFloatingExitButtonBackgroundColor(colour: UIColor) {
        _floatingExitButtonBackgroundColor = colour
    }
    public func setFloatingExitButtonImage(image: UIImage?) {
        _floatingExitButtonImage = resizeImage(image: image)
    }
    func resizeImage(image: UIImage?) -> UIImage? {
  
        let newSize = CGSize(width: 30, height: 30)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image?.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    @IBAction func shareLink(_ sender: UIButton) {
        guard let linkURL = URL(string: _url) else {
                return
            }
        
            let activityViewController = UIActivityViewController(activityItems: [linkURL], applicationActivities: nil)
            
            if let popoverPresentationController = activityViewController.popoverPresentationController {
                popoverPresentationController.sourceView = sender
            }
        
            present(activityViewController, animated: true, completion: nil)
        
    }
    
    
    func setupUI(){

        backgroundView.backgroundColor = _uiBackgroundColor
        floatingExitButton.isHidden = !_isFloatingButtonEnabled

        floatingExitButton.layer.cornerRadius = floatingExitButton.frame.height / 2
        floatingExitButton.layer.masksToBounds = true
        floatingExitButton.backgroundColor = .red
        
        topForwardButtonImage.image = _forwardButtonImage
        bottomForwardButtonImage.image = _forwardButtonImage
        
        topBackButtonImage.image = _backButtonImage
        bottomBackButtonImage.image = _backButtonImage
        
        topReloadButtonImage.image = _reloadButtonImage
        bottomReloadButtonImage.image = _reloadButtonImage
        
        topForwardButtonImage.isHidden = true
        topBackButtonImage.isHidden = true
        bottomForwardButtonImage.isHidden = true
        bottomForwardButtonImage.isHidden = true
        

        switch _buttonConfiguration {
        case .allButtons:
            break
        case .backAndForward:
            topReloadButton.isHidden = true
            bottomReloadButton.isHidden = true
            topReloadButtonImage.isHidden = true
            bottomReloadButtonImage.isHidden = true
            
        case .reload:
            topForwardButton.isHidden = true
            topBackButton.isHidden = true
            bottomForwardButton.isHidden = true
            bottomBackButton.isHidden = true
            
            topForwardButtonImage.isHidden = true
            topBackButtonImage.isHidden = true
            bottomForwardButtonImage.isHidden = true
            bottomForwardButtonImage.isHidden = true
        }
        switch _navigationType {
        case .top:
            bottomViewHeightConstraint.constant = 0
            bottomView.isHidden = true
        case .bottom:
            topForwardButton.isHidden = true
            topBackButton.isHidden = true
            topReloadButton.isHidden = true
        }
        
        floatingExitButton.backgroundColor = _floatingExitButtonBackgroundColor
        floatingExitButton.setImage(_floatingExitButtonImage, for: .normal)

        if let url = URL(string: _url){
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
}

