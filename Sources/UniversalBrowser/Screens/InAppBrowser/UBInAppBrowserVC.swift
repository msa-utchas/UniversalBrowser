//
//  InAppBrowserViewController.swift
//
//
//  Created by MD SAKIBUL ALAM UTCHAS_0088 on 1/11/23.
//

import UIKit
import WebKit


@available(iOS 13.0, *)
public class UBInAppBrowserVC: UIViewController, WKNavigationDelegate, WKUIDelegate{
    
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet weak var toggleButtonImage: UIImageView!
    @IBOutlet weak var toogleButton: UIButton!
    @IBOutlet weak var optionViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var closeCustomOptionsView: UIView!
    @IBOutlet weak var customOptionView: OptionsView!
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
    
    private var _forwardButtonImageDisabled: UIImage? = UIImage(systemName: "arrow.right.circle")!.withTintColor(.gray, renderingMode: .alwaysOriginal)
    private var _backButtonImageDisabled: UIImage? = UIImage(systemName: "arrow.left.circle")!.withTintColor(.gray, renderingMode: .alwaysOriginal)
    
    
    
    
    private var _buttonConfiguration: ButtonConfiguration = .allButtons
    private var _url: String = "apple.com"
    private var _title: String = "apple"
    private var _floatingExitButtonBackgroundColor: UIColor = .green
    private var _floatingExitButtonImage: UIImage? = UIImage(systemName: "arrow.backward")
    
    private var _customOptionsToggle: Bool = true
    private var _isOptionButtonEnabled = false
    
    private var _openingMethod: OpeningMethod = .fromUrlString
    
    
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        activityLoader.stopAnimating()
        activityLoader.isHidden = true
        
        customOptionView.customDelegate = self
        
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        topBackButton.isEnabled = false
        bottomBackButton.isEnabled = false
        
        topForwardButton.isEnabled = false
        bottomForwardButton.isEnabled = false
        
        backgroundView.backgroundColor = .red
        
        
        navigationController?.navigationBar.isHidden = true
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
        setupUI()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.loadNewUrl(_:)),
                                               name: .loadNewUrl, object: nil)
        
    }
    
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == #keyPath(WKWebView.canGoBack) {
            if let newValue = change?[.newKey] as? Bool {
                self.setupBackForwardButton()
                
            }
            else
            {
                self.setupBackForwardButton()
                
            }
            
        }
        if keyPath == #keyPath(WKWebView.canGoForward) {
            if let newValue = change?[.newKey] as? Bool {
                self.setupBackForwardButton()
                
            }
            else{
                self.setupBackForwardButton()
            }
        }
        
        if keyPath == #keyPath(WKWebView.isLoading) {
            if let newValue = change?[.newKey] as? Bool {
                
                if newValue{
                    self.activityLoader.isHidden = false
                    self.activityLoader.startAnimating()
                    
                } else {
                    self.activityLoader.stopAnimating()
                    self.activityLoader.isHidden = true
                }
            }
        }
        
    }
    
    func setupBackForwardButton(){
        
        if(_buttonConfiguration == .allButtons || _buttonConfiguration == .backAndForward){
            
            if webView.canGoBack{
                topBackButton.isEnabled = true
                bottomBackButton.isEnabled = true
                
                topBackButtonImage.image = _backButtonImage!
                bottomBackButtonImage.image = _backButtonImage!
                
            }
            else{
                topBackButton.isEnabled = false
                bottomBackButton.isEnabled = false
                
                topBackButtonImage.image = _backButtonImageDisabled!
                bottomBackButtonImage.image = _backButtonImageDisabled!
                
            }
            if webView.canGoForward{
                topForwardButton.isEnabled = true
                bottomForwardButton.isEnabled = true
                
                
                
                topForwardButtonImage.image = _forwardButtonImage!
                bottomForwardButtonImage.image = _forwardButtonImage!
            }
            else{
                topForwardButton.isEnabled = false
                bottomForwardButton.isEnabled = false
                
                topForwardButtonImage.image = _forwardButtonImageDisabled!
                bottomForwardButtonImage.image = _forwardButtonImageDisabled!
                
                
            }
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
        if let nav = navigationController{
            nav.popViewController(animated: true)
        }
        else{
            self.dismiss(animated: true)
        }
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
    
    @IBAction func toggleOptions(_ sender: Any) {
        
        if(_customOptionsToggle){
            
            openOptionView()
            
        }
        else{
            closeOptionView()
        }
        
    }
    @IBAction func viewTapAction(_ sender: Any) {
        closeOptionView()
    }
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let url = webView.url, let title = webView.title{
            _url = url.absoluteString
            _title = title
            CoredataManager.shared.insertHistory(url: _url, title: _title)
        }
        
    }
    
    
    public func setOptionsButton(isEnabled: Bool){
        _isOptionButtonEnabled = isEnabled
        
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
    public func setForwardButtonImage(enableState: UIImage?, disableState: UIImage?) {
        _forwardButtonImage = enableState
        _forwardButtonImageDisabled = disableState
    }
    public func setBackButtonImage(enableState: UIImage?, disableState: UIImage?) {
        _backButtonImage = enableState
        _backButtonImageDisabled = disableState
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
    
    public func setOpeningMethod(method: OpeningMethod){
        _openingMethod = method
    }
    func resizeImage(image: UIImage?) -> UIImage? {
        
        let newSize = CGSize(width: 30, height: 30)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image?.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func openOptionView() {
        closeCustomOptionsView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.optionViewBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
        _customOptionsToggle.toggle()
    }
    
    func closeOptionView() {
        closeCustomOptionsView.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.optionViewBottomConstraint.constant = -350
            self.view.layoutIfNeeded()
        }
        _customOptionsToggle.toggle()
    }
    
    func setupUI(){
        optionViewBottomConstraint.constant = -350
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
        
        topForwardButtonImage.image = _forwardButtonImageDisabled
        topBackButtonImage.image = _backButtonImageDisabled
        bottomForwardButtonImage.image = _forwardButtonImageDisabled
        bottomBackButtonImage.image = _backButtonImageDisabled
        
        
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
            topBackButtonImage.isHidden = true
            topForwardButtonImage.isHidden = true
            topReloadButtonImage.isHidden = true
        }
        
        floatingExitButton.backgroundColor = _floatingExitButtonBackgroundColor
        floatingExitButton.setImage(_floatingExitButtonImage, for: .normal)
        
        if !_isOptionButtonEnabled{
            toogleButton.isHidden = true
            toggleButtonImage.isHidden = true
        }
        
        
        
        
        
        switch _openingMethod {
        case .fromUrlString:
            if let url = URL(string: _url){
                let request = URLRequest(url: url)
                webView.load(request)
            }
        case .fromFile:
            selectHTMLFile()
        }
        
    }
    
    
    
}

@available(iOS 13.0, *)
extension UBInAppBrowserVC{
    @objc func loadNewUrl(_ notification: NSNotification) {
        if let urlString = notification.userInfo?["url"] as? String, let url = URL(string: urlString) {
            self.setUrl(url: urlString)
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }
}

@available(iOS 13.0, *)
extension UBInAppBrowserVC: OptionsViewDelegate{
    func setBookmark() {
        closeOptionView()
        CoredataManager.shared.insertBookmark(url: _url, title: _title)
    }
    
    func openInBrowser() {
        closeOptionView()
        if let url = URL(string: _url) {
            UIApplication.shared.open(url, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly : false]) { (success) in
                if !success {
                    print("URL failed to open")
                }
            }
        }
    }
    
    func shareLink() {
        closeOptionView()
        guard let linkURL = URL(string: _url) else {
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [linkURL], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    func showHistory() {
        closeOptionView()
        if let vc = UIStoryboard(name: "History", bundle: Bundle.module).instantiateViewController(withIdentifier: "HistoryVC") as? HistoryVC{
            self.present(vc, animated: true)
        }
    }
    
    func showBookmarks() {
        closeOptionView()
        if let vc = UIStoryboard(name: "Bookmark", bundle: Bundle.module).instantiateViewController(withIdentifier: "BookmarkVC") as? BookmarkVC{
            self.present(vc, animated: true)
        }
    }
}





@available(iOS 13.0, *)
extension UBInAppBrowserVC: UIDocumentPickerDelegate{
    func selectHTMLFile() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.html"], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
    
    func loadHTMLFile(from url: URL) {
        
        print(url)

        webView.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        webView.load(request)
        
    }
    
    
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let selectedFileURL = urls.first {
            loadHTMLFile(from: selectedFileURL)
        }
    }
}

