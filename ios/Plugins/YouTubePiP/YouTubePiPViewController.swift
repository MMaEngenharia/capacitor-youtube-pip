import UIKit
import WebKit

class YouTubePiPViewController: UIViewController {
    var webView: WKWebView!
    var videoId: String

    init(videoId: String) {
        self.videoId = videoId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: view.bounds)
        view.addSubview(webView)

        let url = URL(string: "https://www.youtube.com/embed/\(videoId)?playsinline=1&autoplay=1")!
        webView.load(URLRequest(url: url))
    }
}