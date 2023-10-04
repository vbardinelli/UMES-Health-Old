import UIKit
import AVFoundation

class WelcomeViewController: UIViewController {
    var birdImageView: UIImageView!
    var audioPlayer: AVAudioPlayer!
    
    @IBOutlet weak var UMESLoginImage: UIImageView!
    @IBOutlet weak var UMESLoginButton: UIButton!
    
    let numberOfFrames = 15 // Update this with the actual number of animation frames
    let birdWidth: CGFloat = 100 // Width of the birdImageView
    let birdHeight: CGFloat = 100 // Height of the birdImageView

    override func viewDidLoad() {
        super.viewDidLoad()

        self.UMESLoginButton.alpha = 0.0
        self.UMESLoginImage.alpha = 0.0
        
        birdImageView = UIImageView(frame: CGRect(x: -birdWidth, y: 0, width: birdWidth * 0.75, height: birdHeight * 0.75)) // Start 25% smaller
        view.addSubview(birdImageView)
        
        // Load the audio file and prepare the audio player
        if let audioFilePath = Bundle.main.path(forResource: "HawkScreech", ofType: "wav") {
            let audioFileURL = URL(fileURLWithPath: audioFilePath)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioFileURL)
                audioPlayer.prepareToPlay()
            } catch {
                print("Error loading audio file: \(error)")
            }
        }

        // Configure bird animation
        configureBirdAnimation()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Start bird animation and show text fields with fade-in
        startBirdAnimation()
    }

    private func configureBirdAnimation() {
        var birdAnimationImages: [UIImage] = []

        for i in 1...numberOfFrames {
            if let frameImage = UIImage(named: "birdframe\(i)") {
                birdAnimationImages.append(frameImage)
            }
        }

        birdImageView.animationImages = birdAnimationImages
        birdImageView.animationDuration = 9.5 // Adjust the duration as needed
        birdImageView.animationRepeatCount = 1
    }

    private func startBirdAnimation() {
        birdImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8) // Start 20% smaller
        birdImageView.startAnimating()

        // Create a symmetrical curve path
        let path = UIBezierPath()
        path.move(to: CGPoint(x: -birdWidth, y: 0))

        let controlPointY = view.frame.height * 0.72 // Middle of the screen
        path.addQuadCurve(to: CGPoint(x: view.frame.width - 100, y: 0), controlPoint: CGPoint(x: view.frame.width / 2, y: controlPointY))

        // Animate bird along the symmetrical curve path
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.duration = 9.5
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards

        birdImageView.layer.add(animation, forKey: "pathAnimation")

        // Play audio after a 1-second delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.audioPlayer.play()
        }

        // Scale animation
        UIView.animate(withDuration: animation.duration * 0.4, animations: {
            self.birdImageView.transform = CGAffineTransform(scaleX: 1.4, y: 1.4) // Maximum scale of 1.4
        }) { _ in
            // Pause for 1 second (pause the bird's movement)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                UIView.animate(withDuration: animation.duration * 0.1, animations: {
                    self.birdImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2) // Original size
                }) { _ in
                    // Continue the animation and scaling down
                    UIView.animate(withDuration: animation.duration * 0.2, animations: {
                        self.birdImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5) // End 50% bigger
                    }) { _ in
                        // Animation completion: gradually increase opacity of text fields and images
                        let fadeDuration = 1.125 // Buttons' fade-in completion time (half of original)
                        UIView.animate(withDuration: fadeDuration, animations: {
                            self.UMESLoginButton.alpha = 1.0
                            self.UMESLoginImage.alpha = 1.0
                        }) { _ in
                            // Additional animations if needed
                        }
                    }
                }
            }
        }
    }
}
