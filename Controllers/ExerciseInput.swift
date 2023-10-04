import UIKit

class ExerciseInputViewController: UIViewController {
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!

    weak var moodTracker: MoodTrackerViewController?

    @IBAction func exerciseButtonTapped(_ sender: UIButton) {
        let didExercise = sender == yesButton
        globalMoodDatas[globalMoodDatas.count - 1].didExercise = didExercise
        moodTracker?.proceedToDisplay()
    }
}
