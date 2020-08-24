//
//  HistoryInfo.swift
//  pointCard
//
//  Created by 郭冠杰 on 2020/6/6.
//  Copyright © 2020 郭冠杰. All rights reserved.
//

import SwiftUI



var systemTime = DateComponents(hour: UserDefaults.standard.integer(forKey: "hour_sys"),minute: UserDefaults.standard.integer(forKey: "min_sys"), second: UserDefaults.standard.integer(forKey: "sec_sys"))

//var initialTime = DateComponents(hour: 0, minute: 0, second: 0)

var initialTime = DateComponents(hour: UserDefaults.standard.integer(forKey: "hour_ini"),minute: UserDefaults.standard.integer(forKey: "min_ini"), second: UserDefaults.standard.integer(forKey: "sec_ini"))

var tempTime_today = DateComponents(hour: UserDefaults.standard.integer(forKey: "hour_temp"),minute: UserDefaults.standard.integer(forKey: "min_temp"), second: UserDefaults.standard.integer(forKey: "sec_temp"))

var residualTime_hour = 0
var residualTime_minute = 0
var residualTime_second = 0


var userCardColor = UserDefaults.standard.string(forKey: "color")
var userCardWord = UserDefaults.standard.array(forKey: "word") as? [String] ?? ["加", "油"]

//var userCardColor = "綠"
//var userCardWord = ["加", "油"]

let wordType = [
    
    ["加", "油"], ["勇", "氣"], ["希", "望"], ["必", "勝"], ["師", "弟"]
]


let colorType = [
    
    "紅": Color(red: 240/255, green: 200/255, blue: 190/255),
    "黃": Color(red: 248/255, green: 237/255, blue: 187/255),
    "綠": Color(red: 180/255, green: 230/255, blue: 210/255),
    "藍": Color(red: 180/255, green: 210/255, blue: 230/255),
    "紫": Color(red: 200/255, green: 180/255, blue: 210/255)
    
]



struct HistoryData: Codable {
    
    let word: [String]
    let num: String
    let cardColor: String
    let startTime: [String]
    var endTime: [String]?
    
}

//var historydata = [
//
//    HistoryData(word: ["加", "油"], num: "1", cardColor: "紅", startTime: ["2020", "5", "31"], endTime: nil),
//    HistoryData(word: ["勇", "氣"], num: "2", cardColor: "黃", startTime: ["2020", "5", "31"], endTime: ["2020", "4", "5"]),
//    HistoryData(word: ["希", "望"], num: "3", cardColor: "綠", startTime: ["2020", "5", "31"], endTime: ["2020", "4", "5"]),
//    HistoryData(word: ["必", "勝"], num: "4", cardColor: "藍", startTime: ["2020", "5", "31"], endTime: ["2020", "4", "5"]),
//    HistoryData(word: ["師", "弟"], num: "5", cardColor: "紫", startTime: ["2020", "5", "31"], endTime: ["2020", "4", "5"])
//
//]

/*
func saveHistorydata() {
    if let data = try? JSONEncoder().encode(historydata) {
        UserDefaults.standard.set(data, forKey: "historydata")
    }
}

func readHistorydata()  {
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
*/

struct HistoryInfo: View {
    
    @EnvironmentObject var historyDataStore: HistoryDataStore
    
    var body: some View {
        return NavigationView{
            
            ZStack{
                
                LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 160/255, blue: 200/255), Color(red: 120/255, green: 180/255, blue: 220/255)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                
                
                
                ScrollView (showsIndicators: false) {
                    
                    
                    VStack{
                        
                        ForEach(0..<historyDataStore.historydata.count, id: \.self) { item in
                            CardRow(data: self.historyDataStore.historydata[item])
                           // Text(historydata[item].word.description)
                        }
                        
                    }
                }
                
            }
            .navigationBarTitle("歷史紀錄", displayMode: .inline)
           
        } // NavigationView
        
    }
}

struct HistoryInfo_Previews: PreviewProvider {
    static var previews: some View {
        let historyDataStore = HistoryDataStore()
        return HistoryInfo().environmentObject(historyDataStore)
    }
}
