import Capacitor
import AVKit
import WebKit

@objc(YouTubePiPPlugin)
public class YouTubePiPPlugin: CAPPlugin {
    @objc func open(_ call: CAPPluginCall) {
        guard let videoId = call.getString("videoId") else {
            call.reject("videoId obrigatório")
            return
        }

        DispatchQueue.main.async {
            let pipVC = YouTubePiPViewController(videoId: videoId)
            self.bridge?.viewController?.present(pipVC, animated: true, completion: {
                call.resolve()
            })
        }
    }
}