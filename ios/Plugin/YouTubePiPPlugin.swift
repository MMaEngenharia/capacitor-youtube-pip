import Capacitor
import AVKit
import WebKit

@objc(YouTubePiPPlugin)
public class YouTubePiPPlugin: CAPPlugin {

    private var pipController: AVPictureInPictureController?
    private var playerViewController: AVPlayerViewController?
    private var youtubeWebView: WKWebView?
    
    @objc func play(_ call: CAPPluginCall) {
        guard let videoId = call.getString("videoId") else {
            call.reject("videoId é obrigatório")
            return
        }
        
        DispatchQueue.main.async {
            // Configuração do WebView
            let webConfiguration = WKWebViewConfiguration()
            webConfiguration.allowsInlineMediaPlayback = false
            webConfiguration.mediaTypesRequiringUserActionForPlayback = []
            
            self.youtubeWebView = WKWebView(frame: UIScreen.main.bounds, configuration: webConfiguration)
            guard let webView = self.youtubeWebView else { return }
            
            let urlString = "https://www.youtube.com/embed/\(videoId)?playsinline=1&autoplay=1"
            if let url = URL(string: urlString) {
                webView.load(URLRequest(url: url))
            }
            
            // Configuração do Player
            let playerVC = AVPlayerViewController()
            playerVC.allowsPictureInPicturePlayback = true
            playerVC.showsPlaybackControls = true
            playerVC.contentOverlayView?.addSubview(webView)
            
            
            // Configuração do PiP
            let player = AVPlayer(url: URL(string: "about:blank")!)
            playerVC.player = player
            
            if AVPictureInPictureController.isPictureInPictureSupported() {
                let playerLayer = AVPlayerLayer(player: player)
                playerLayer.frame = UIScreen.main.bounds
                playerLayer.backgroundColor = UIColor.clear.cgColor
                playerVC.contentOverlayView?.layer.addSublayer(playerLayer)
                
                self.pipController = AVPictureInPictureController(playerLayer: playerLayer)
                self.pipController?.delegate = self
            }
            
            // Apresentação
            self.playerViewController = playerVC
            self.bridge?.viewController?.present(playerVC, animated: true) {
                call.resolve()
                
                // Ativa PiP após 2 segundos (opcional)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    //self.togglePiP()
                }
            }
        }
    }
    
    @objc func togglePiP() {
        guard let pipController = pipController else { return }
        
        if pipController.isPictureInPictureActive {
            pipController.stopPictureInPicture()
        } else {
            pipController.startPictureInPicture()
        }
    }
    
    @objc func close(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            self.cleanup()
            call.resolve()
        }
    }
    
    private func cleanup(keepPiPActive: Bool = false) {
        if !keepPiPActive {
            pipController?.stopPictureInPicture()
            pipController = nil
        }

        playerViewController?.player?.pause()
        playerViewController?.dismiss(animated: true)
        playerViewController = nil

        youtubeWebView?.stopLoading()
        youtubeWebView?.removeFromSuperview()
        youtubeWebView = nil
    }
    
    private func removeMainPlayerViewSafely() {
        // Apenas remova se ainda não foi removido
        guard let playerVC = self.playerViewController else { return }

        // Dismiss da view controller sem afetar o PiP (agora já está ativo)
        playerVC.dismiss(animated: false) {
            self.youtubeWebView?.removeFromSuperview()
            self.youtubeWebView = nil
            self.playerViewController = nil
        }
    }
}


 extension YouTubePiPPlugin: AVPictureInPictureControllerDelegate {
     public func pictureInPictureControllerDidStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
         notifyListeners("pipStarted", data: nil)
     
         // Aguarde brevemente antes de remover o player principal
         DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
             self.removeMainPlayerViewSafely()
         }
     }
     
     public func pictureInPictureControllerDidStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        notifyListeners("pipStopped", data: nil)
        
        DispatchQueue.main.async {
            self.cleanup()
        }
     }
     
     public func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController,
        failedToStartPictureInPictureWithError error: Error) {
        notifyListeners("pipError", data: ["error": error.localizedDescription])
     }
 }
 
