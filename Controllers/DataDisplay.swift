import UIKit

class DataDisplayViewController: UIViewController {
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var averageMoodLabel: UILabel! // Make sure to add this UILabel in your storyboard

    override func viewDidLoad() {
        super.viewDidLoad()
        displayData()
    }
    
    func displayData() {
        if let lastMoodData = globalMoodDatas.last {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            
            moodLabel.text = "Mood: \(lastMoodData.moodRank)"
            exerciseLabel.text = "Exercise: \(lastMoodData.didExercise ? "Yes" : "No")"
            dateLabel.text = "Date: \(dateFormatter.string(from: lastMoodData.date))"
            
            let avgMood = averageMood()
            averageMoodLabel.text = "Average Mood: \(String(format: "%.2f", avgMood))"
        } else {
            moodLabel.text = "No data available"
            exerciseLabel.text = ""
            dateLabel.text = ""
            averageMoodLabel.text = "Average Mood: Not available"
        }
    }
}
