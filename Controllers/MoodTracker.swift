import UIKit

class MoodTrackerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mood Tracker"
    }

    @IBAction func moodButtonTapped(_ sender: UIButton) {
        let moodRank = sender.tag
        guard (1...5).contains(moodRank) else {
            print("Invalid moodRank: \(moodRank)")
            return
        }

        if let lastEntryDate = globalMoodDatas.last?.date {
            let calendar = Calendar.current
            if calendar.isDateInToday(lastEntryDate) {
                showAlert(title: "Entry exists", message: "You've already recorded your mood for today.")
                return
            }
        }

        let newMoodData = MoodData(date: Date(), moodRank: moodRank, didExercise: false)
        globalMoodDatas.append(newMoodData)

        performSegue(withIdentifier: "ExerciseInput", sender: self)
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func proceedToDisplay() {
        performSegue(withIdentifier: "DataDisplay", sender: self)
    }
}
