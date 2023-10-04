//
//  Announcements2.swift
//  UMES Health
//
//  Created by Bardinelli, Vincent R on 10/4/23.
//

import UIKit
import WebKit

class Announcements2: UIViewController {

    @IBOutlet weak var webView2: WKWebView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Announcements"

        if let url = URL(string: "https://wwwcp.umes.edu/events/") {
            let request = URLRequest(url: url)
            webView2.load(request)
        }
    }
    

}
