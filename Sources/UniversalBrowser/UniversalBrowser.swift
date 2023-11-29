import Foundation


public enum NavigationType {
    case top
    case bottom
}

public enum ButtonConfiguration {
    case allButtons
    case backAndForward
    case reload
}

public enum OpeningMethod {
    case fromUrlString
    case fromFile
}

public enum UBVCType:String {
    case inAppBrowser = "InAppBrowserView"
    case userAuth = "UserAuthVC"
    case payment = "PaymentVC"
    case htmlCssEditor = "HtmlCssEditor"
}

