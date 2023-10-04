import UIKit
import WebKit
import FirebaseAuth

class AnnouncementsViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load a webpage when the view loads
        if let url = URL(string: "https://wwwcp.umes.edu/events/") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }

    private func validateAuth()
    {
        if FirebaseAuth.Auth.auth().currentUser == nil
        {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
}
