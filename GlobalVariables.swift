import Foundation

struct MoodData {
    var date: Date
    var moodRank: Int
    var didExercise: Bool
}

var globalMoodDatas: [MoodData] = []

func averageMood() -> Double {
    guard !globalMoodDatas.isEmpty else { return 0.0 }
    let sum = globalMoodDatas.reduce(0) { $0 + $1.moodRank }
    return Double(sum) / Double(globalMoodDatas.count)
}
