import UIKit

class WelcomeNewViewController: UIViewController {
    
    @IBOutlet weak var hawkImageView: UIImageView!
    
    // Add IBOutlets for your UI elements here
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var TextField3: UIButton!
    @IBOutlet weak var LoggedIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set initial position and size of the hawk image (50% of the current size) at the top-left corner
        let initialSize = CGSize(width: hawkImageView.bounds.size.width * 0.5, height: hawkImageView.bounds.size.height * 0.5)
        hawkImageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: initialSize)
        
        // Set initial alpha values for UI elements to make them invisible
        textField1.alpha = 0.0
        textField2.alpha = 0.0
        image1.alpha = 0.0
        image2.alpha = 0.0
        button1.alpha = 0.0
        button2.alpha = 0.0
        TextField3.alpha = 0.0
        LoggedIn.alpha = 0.0
        
        // Start the animation
        animateHawk()
    }
    
    func animateHawk() {
        UIView.animate(withDuration: 2.5, delay: 1.5, options: .curveEaseInOut, animations: {
            // Calculate the final size of the hawk image (50x bigger) while keeping the center position
            let finalSize = CGSize(width: self.hawkImageView.bounds.size.width * 50.0, height: self.hawkImageView.bounds.size.height * 50.0)
            self.hawkImageView.frame.size = finalSize
            
            // Calculate the final position to be 20% higher on the screen while keeping it centered horizontally
            let finalX = (self.view.bounds.size.width - finalSize.width) / 2
            let finalY = (self.view.bounds.size.height - finalSize.height) * 0.2 / 2
            self.hawkImageView.frame.origin = CGPoint(x: finalX, y: finalY)
        }) { (_) in
            // Animation completion code (if needed)
            
            // Call the function to animate the UI elements
            self.animateUIElements()
        }
    }
    
    func animateUIElements() {
        // Add fade-in animations for your UI elements here
        UIView.animate(withDuration: 1.0) {
            self.textField1.alpha = 1.0
            self.textField2.alpha = 1.0
            self.image1.alpha = 1.0
            self.image2.alpha = 1.0
            self.button1.alpha = 1.0
            self.button2.alpha = 1.0
            self.TextField3.alpha = 1.0
            self.LoggedIn.alpha = 1.0
        }
    }
}
