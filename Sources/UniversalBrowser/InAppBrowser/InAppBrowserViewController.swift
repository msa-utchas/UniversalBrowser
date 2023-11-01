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
    @IBOutlet weak var flottingExitButton: UIButton!
    
    public static let viewController = UIStoryboard(name: "UBStoryBoard", bundle: Bundle.module).instantiateViewController(withIdentifier: "InAppBrowserView") as! InAppBrowserViewController
    
    private var _uiBackgroundColor: UIColor = .white
    private var _navigationType: NavigationType = .top
    private var _isFloatingButtonEnabled: Bool = false
    
    private var _forwardButtonImage: UIImage? = UIImage(systemName: "arrow.right.circle")
    private var _backButtonImage: UIImage? = UIImage(systemName: "arrow.left.circle")
    private var _reloadButtonImage: UIImage? = UIImage(systemName: "arrow.clockwise.circle")
    private var _buttonConfiguration: ButtonConfiguration = .allButtons


    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        topBackButton.isEnabled = false
        bottomBackButton.isEnabled = false
        
        topForwardButton.isEnabled = false
        bottomForwardButton.isEnabled = false
        
        //bottomViewHeightConstraint.constant = 0
        //bottomView.isHidden = true

        // change background color
        backgroundView.backgroundColor = .red
        
        
        navigationController?.navigationBar.isHidden = true
        if let url = URL(string: "https://www.apple.com") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
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

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView.canGoBack{
            topBackButton.isEnabled = true
            bottomBackButton.isEnabled = true
        }
        else{
            topBackButton.isEnabled = false
            bottomBackButton.isEnabled = false
        }
        if webView.canGoForward{
            topForwardButton.isEnabled = true
            bottomForwardButton.isEnabled = true
        }
        else{
            topForwardButton.isEnabled = false
            bottomForwardButton.isEnabled = false
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
    
    func resizeImage(image: UIImage?) -> UIImage? {
  
        let newSize = CGSize(width: 30, height: 30)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image?.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    func setupUI(){

        backgroundView.backgroundColor = _uiBackgroundColor
        flottingExitButton.isHidden = !_isFloatingButtonEnabled
        
        topForwardButton.setImage(_forwardButtonImage, for: .normal)
        topBackButton.setImage(_backButtonImage, for: .normal)
        topReloadButton.setImage(_reloadButtonImage, for: .normal)
        bottomForwardButton.setImage(_forwardButtonImage, for: .normal)
        bottomBackButton.setImage(_backButtonImage, for: .normal)
        bottomReloadButton.setImage(_reloadButtonImage, for: .normal)

        switch _buttonConfiguration {
        case .allButtons:
            break
        case .backAndForward:
            topReloadButton.isHidden = true
            bottomReloadButton.isHidden = true
        case .reload:
            topForwardButton.isHidden = true
            topBackButton.isHidden = true
            bottomForwardButton.isHidden = true
            bottomBackButton.isHidden = true
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
    }
}

