//
//  HistoryDataStore.swift
//  pointCard
//
//  Created by 郭冠杰 on 2020/6/28.
//  Copyright © 2020 郭冠杰. All rights reserved.
//

import Foundation

class HistoryDataStore: ObservableObject {
    @Published var historydata: [HistoryData]
    
    func saveHistorydata() {
        if let data = try? JSONEncoder().encode(historydata) {
            UserDefaults.standard.set(data, forKey: "historydata")
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "historydata") {
               historydata = (try? JSONDecoder().decode([HistoryData].self, from: data)) ?? []
               
           } else {
               
               //        let initial = Calendar.current.dateComponents([.year, .month, .day], from: Date())
               //
               //        let initialYear = String(initial.year!)
               //        let initialMonth = String(initial.month!)
               //        let initialDay = String(initial.day!)
               
               let now = Date()
               
               let formatter = DateFormatter()
               
               formatter.timeZone = TimeZone.current
               
               formatter.dateFormat = "yyyy-MM-dd-HH-mm"
               
               let dateString = formatter.string(from: now)
               
               //        print(dateString)
               
               let dateString_split = dateString.split(separator: Character("-"))
               
               let initialYear = String(dateString_split[0])
               let initialMonth = String(dateString_split[1])
               let initialDay = String(dateString_split[2])
               
            historydata = [HistoryData(word: ["加", "油"], num: "1", cardColor: "綠", startTime: [initialYear, initialMonth, initialDay], endTime: nil)]
               
               saveHistorydata()
           }
    }
}
